//
//  Cast.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

struct Cast: Codable {
    var castId: Int
    var character: String
    var name: String
    var order: Int
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case castId = "cast_id"
        case character
        case name
        case order
        case imageUrl = "profile_path"
    }
    
    func profileImage(width: Int = 500, height: Int = 282) -> String? {
        if let url = imageUrl {
            return "https://image.tmdb.org/t/p/w\(width)_and_h\(height)_face" + url
        }
        
        return nil
    }
}
