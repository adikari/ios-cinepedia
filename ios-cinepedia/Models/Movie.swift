//
//  Movie.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation


struct Movie: Codable {
    var id: Int
    var title: String
    var status: String
    var description: String
    var tagline: String
    var rating: Double
    var imageUrl: String
    var imdbId: String
    var releaseDate: Date
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case title
        case status
        case description = "overview"
        case tagline
        case rating = "vote_average"
        case imageUrl = "poster_path"
        case imdbId = "imdb_id"
        case releaseDate = "release_date"
    }
}
