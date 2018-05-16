//
//  MovieDetail.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 16/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

struct Genre: Codable {
    var id: Int
    var name: String
}

struct MovieDetail: Codable {
    var id: Int
    var title: String
    var description: String
    var rating: Double
    var totalVotes: Int
    var imageUrl: String?
    var backdropUrl: String?
    var releaseDate: String
    var genres: [Genre]
    var runtime: Int
    
    func backdrop(width: Int = 500, height: Int = 282) -> String? {
        if let url = backdropUrl {
            return "https://image.tmdb.org/t/p/w\(width)_and_h\(height)_face" + url
        }
        
        return nil
    }
    
    func poster(width: Int = 500, height: Int = 282) -> String? {
        if let url = imageUrl {
            return "https://image.tmdb.org/t/p/w\(width)_and_h\(height)_face" + url
        }
        
        return nil
    }
}

extension MovieDetail {
    enum CodingKeys: String, CodingKey
    {
        case id
        case title
        case description = "overview"
        case rating = "vote_average"
        case imageUrl = "poster_path"
        case backdropUrl = "backdrop_path"
        case releaseDate = "release_date"
        case totalVotes = "vote_count"
        case genres
        case runtime
    }
}
