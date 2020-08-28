//
//  iTunesEndpoint.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 28.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
private let iTunesBaseURL = "https://itunes.apple.com"

enum ITunesEndpoint {
    case search(term: String = "Solomun", limit: Int)
}

extension ITunesEndpoint: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: iTunesBaseURL) else { fatalError("baseURL has not been defined !")}
        return url
    }
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    var task: HTTPTask {
        switch self {
        case .search(let term, let limit):
            return .requestParameters(bodyParameters: .urlEncoding, urlParameters:["term": term,
                                                                                   "limit": limit])
        }
    }
    var headers: HTTPHeaders? {
        //for our case we do not need header but it can be available for in the future.
        return nil
    }
}
