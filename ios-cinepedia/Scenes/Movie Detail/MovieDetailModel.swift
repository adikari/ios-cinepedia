//
//  MovieDetailModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum MovieDetailModel {
    
    enum FetchFavourite {
        struct Request {
            var movieId: Int
        }
        
        struct Response {
            var isFavourite: Bool
        }
        
        struct ViewModel {
            var isFavourite: Bool
        }
    }
    
    enum SetFavourite {
        struct Request {
            var movie: FetchMovieDetail.ViewModel.Movie
            var isFavourite: Bool
        }
        
        struct Response {
            var isFavourite: Bool
        }
        
        struct ViewModel {
            var isFavourite: Bool
        }
    }
    
    enum FetchMovieDetail {
        struct Request {
            var movieId: Int
        }
        
        struct Response {
            var movie: MovieDetail?
        }
        
        struct ViewModel {
            
            struct Movie {
                var id: Int
                var title: String
                var description: String
                var posterUrl: String?
                var backdropUrl: String?
                var runtime: String
                var genres: String
                var year: String
                var status: String
                var rating: String
            }
            
            var movie: Movie
        }
    }
    
}
