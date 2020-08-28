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
                completion: @escaping ClosureType<SearchResults>,
                failure: @escaping Failure) {
                provider.httpRequest(.search(term: text,
                                     limit: limit),
                                     model: SearchResults.self,
                                     completion: completion,
                                     failure: failure)
    }
}
