//
//  HTTPTask.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 24.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String: String]
public enum HTTPTask {
    /*
     HTTPTask is account to configuration of parameters which has specific reasons.
     */
    case request
    case requestParameters(bodyParameters: ParameterEncoding,
        urlParameters: Parameters)
    // case download, upload...etc
}
