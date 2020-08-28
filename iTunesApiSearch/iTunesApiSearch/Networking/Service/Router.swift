//
//  Router.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 27.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
typealias ClosureType<T> = (_ result: T) -> Void
typealias Failure = ((_ error: String) -> Void)
class Router<EndPoint: EndPointType>: NetworkRouter {
    // MARK: - Variables
    private var task: URLSessionTask?
    // MARK: - Base Request
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    // MARK: - Suspend Request for async tasks
    func cancel() {
        self.task?.cancel()
    }
    // MARK: - Request Configration
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    // MARK: - Configure Parameters
    fileprivate func configureParameters(bodyParameters: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyParameters.encode(urlRequest: &request, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    // MARK: - Additional Headers
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?,
                                          request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
extension Router {
    func httpRequest<T: Decodable>(_ target: EndPoint,
                                   model: T.Type,
                                   path: String? = nil,
                                   completion: @escaping ClosureType<T>,
                                   failure: @escaping Failure) {

        return request(target, completion: { data, response, error in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            failure(NetworkError.noData.rawValue)
                            return
                        }
                        do {
                            let jsonData = try JSONSerialization.jsonObject(with: responseData,
                                                                            options: .mutableContainers)
                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(model.self, from: responseData)
                            completion(apiResponse)
                        } catch {
                            print(error.localizedDescription)
                            failure(NetworkError.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        failure(networkFailureError)
                    }
                } else {
                    failure(NetworkError.noData.rawValue)
                }
            }
        })
    }
    private enum Result<String> {
        case success
        case failure(String)
    }
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkError.authenticationError.rawValue)
        case 501...599: return .failure(NetworkError.badRequest.rawValue)
        case 600: return .failure(NetworkError.outdated.rawValue)
        default: return .failure(NetworkError.failed.rawValue)
        }
    }
}
