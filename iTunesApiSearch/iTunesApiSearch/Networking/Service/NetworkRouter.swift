//
//  NetworkRouter.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 27.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()
protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
