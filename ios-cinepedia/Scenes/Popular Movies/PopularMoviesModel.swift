//
//  FeaturedMovieModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

enum PopularMovies
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
        }

        var movies: [Movie]
    }
}
