//
//  NetworkError.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 27.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingUrl = "URL is nil."
}
