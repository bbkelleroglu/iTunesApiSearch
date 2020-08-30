//
//  NetworkManager.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 28.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
struct NetworkManager {
    // MARK: - Instances
    static let shared = NetworkManager()
    private let provider = Router<ITunesEndpoint>()
    // MARK: - Functions
    func search(text: String,
                limit: Int = 100,
                completion: @escaping ClosureType<[SearchModel]?>,
                failure: @escaping Failure) {
        return provider.request(.search(term: text, limit: limit)) { data, response, error in
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
                            let apiResponse = try JSONDecoder().decode(SearchResults.self, from: responseData)
                            completion(apiResponse.results)
                        } catch {
                            print(error)
                            failure(NetworkError.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        failure(networkFailureError)
                    }
                } else {
                    failure(NetworkError.noData.rawValue)
                }
            }
        }
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
