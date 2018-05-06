//
//  FeaturedMovieModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

enum ListMovies
{
    // MARK: Use cases
    
    enum Featured
    {
        struct Request
        {
        }
        
        struct Response
        {
            var movie: Movie?
        }
        
        struct ViewModel
        {
            struct FeaturedMovie
            {
                var imageUrl: String
                var title: String
            }
            
            var featuredMovie: FeaturedMovie
        }
    }
}
