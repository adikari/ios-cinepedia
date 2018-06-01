//
//  FavouriteMovie.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 1/6/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

struct FavouriteMovie {
    var id: Int
    var title: String
    var description: String
    var imageUrl: String?
    
    func image(width: Int = 500, height: Int = 282) -> String? {
        if imageUrl != nil {
            return "https://image.tmdb.org/t/p/w\(width)_and_h\(height)_face" + imageUrl!
        }
        
        return nil
    }
}
