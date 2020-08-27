//
//  Service.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 24.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
protocol EndPointType {
    /*
     This protocol will contain all the infomation to configure an Endpoint.
     */
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
