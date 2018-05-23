//
//  ReviewModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum ReviewModel {
    enum FetchReview {
        struct Request {
            var movieId: Int
        }
        
        struct Response {
            var reviews: [Review]
        }
        
        struct ViewModel {
            struct Review {
                var author: String
                var content: String
            }
            
            var reviews: [Review]
        }
    }
}
