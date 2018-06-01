//
//  FavouriteMovieModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 31/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum FavouriteMovieModel {
    enum FetchFavouriteMovies {
        struct Response {
            var movies: [FavouriteMovie]
        }
        
        struct Request { }
        
        struct ViewModel {
            struct Movie {
                var id: Int
                var title: String
                var imageUrl: String
                var description: String
            }
            
            var movies: [Movie]
        }
    }
}
