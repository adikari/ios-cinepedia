//
//  StringExtension.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 16/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
