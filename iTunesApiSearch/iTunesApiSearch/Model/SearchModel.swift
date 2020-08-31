//
//  SearchModel.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 28.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
struct SearchResults: Decodable {
    let resultCount: Int
    let results: [SearchModel]
}

// MARK: - Result
struct SearchModel: Decodable {
    let trackId: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let collectionArtistName: String?
    let artworkUrl100: String
    let trackCensoredName: String
    let country: String
}
