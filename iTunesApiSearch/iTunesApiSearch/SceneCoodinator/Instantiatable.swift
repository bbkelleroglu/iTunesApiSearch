//
//  Instantiatable.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 30.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
import UIKit

protocol Instantiatable {
    static func instantiate() -> Self
}

extension Instantiatable where Self: StoryboardLoadable {
    static func instantiate() -> Self {
        return loadFromStoryboard()
    }
}
