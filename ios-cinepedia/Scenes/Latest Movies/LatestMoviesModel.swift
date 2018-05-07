//
//  LatestMoviesModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 7/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum LatestMovies
{
    // MARK: Use cases
    
    struct Request
    {
    }
    
    struct Response
    {
        var movies: [Movie]
    }
    
    struct ViewModel
    {
        struct Movie
        {
            var imageUrl: String
            var title: String
            var rating: String
        }
        
        var movies: [Movie]
    }
}
