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

struct MovieDetail {
    var id: Int
    var title: String
    var description: String?
    var rating: Double
    var totalVotes: Int
    var imageUrl: String?
    var backdropUrl: String?
    var releaseDate: Date
    var genres: [Genre]
    var runtime: Int
    var status: String
    
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
    
    enum CodingKeys: String, CodingKey {
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
        case status
    }
}

extension MovieDetail: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String?.self, forKey: .description)
        rating = try values.decode(Double.self, forKey: .rating)
        imageUrl = try values.decode(String?.self, forKey: .imageUrl)
        backdropUrl = try values.decode(String?.self, forKey: .backdropUrl)
        totalVotes = try values.decode(Int.self, forKey: .totalVotes)
        genres = try values.decode([Genre].self, forKey: .genres)
        runtime = try values.decode(Int.self, forKey: .runtime)
        status = try values.decode(String.self, forKey: .status)
        
        let date = try values.decode(String.self, forKey: .releaseDate)
        releaseDate = date.toDate
    }
   
}
