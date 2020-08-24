//
//  iTunesApiSearchUITests.swift
//  iTunesApiSearchUITests
//
//  Created by Burak Kelleroğlu on 24.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import XCTest

class ITunesApiSearchUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
