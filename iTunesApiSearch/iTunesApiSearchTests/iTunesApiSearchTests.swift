//
//  iTunesApiSearchTests.swift
//  iTunesApiSearchTests
//
//  Created by Burak Kelleroğlu on 24.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//  swiftlint:disable all

import XCTest
import UIKit
@testable import iTunesApiSearch

class ITunesApiSearchTests: XCTestCase {

    var mainViewModel: MainViewModel!

    override func setUp() {
        viewModelItemSet()
    }
    func viewModelItemSet() {
        let items = [SearchModel(trackId: 1,
                                 artistName: "Solomun",
                                 collectionName: "Solomun",
                                 trackName: "The Way Back",
                                 collectionArtistName: "Solomun",
                                 artworkUrl100: "https://is5-ssl.mzstatic.com/image/thumb/Music/v4/d3/48/76/d34876d1-0a1d-76dc-246a-3d6bb83a0573/source/100x100bb.jpg",
                                 trackCensoredName: "Solomun",
                                 country: "GER")]
        mainViewModel = MainViewModel(state: MainViewState(items: items))
    }
    func testNumberOfItems() {
        XCTAssertEqual(mainViewModel.numberOfItem, 1)
    }
}
