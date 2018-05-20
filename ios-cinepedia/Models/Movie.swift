//
//  Movie.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

struct Movie {
    var id: Int
    var title: String
    var description: String
    var rating: Double
    var imageUrl: String?
    var releaseDate: Date

    func image(width: Int = 500, height: Int = 282) -> String? {
        if imageUrl != nil {
            return "https://image.tmdb.org/t/p/w\(width)_and_h\(height)_face" + imageUrl!
        }
        
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case rating = "vote_average"
        case imageUrl = "poster_path"
        case releaseDate = "release_date"
    }
}

extension Movie: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        rating = try values.decode(Double.self, forKey: .rating)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)

        let date = try values.decode(String.self, forKey: .releaseDate)
        releaseDate = date.toDate
    }
}


