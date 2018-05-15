//
//  MovieDetailModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum MovieDetailModel {
    enum FetchMovieDetail {
        struct Request {
            var movieId: Int
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
            struct Movie {
                var id: Int
                var title: String
                var description: String
            }
            
            var movie: Movie
        }
    }
    
}
