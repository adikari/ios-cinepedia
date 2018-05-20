//
//  DateExtension.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 20/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

extension Date {
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
}
