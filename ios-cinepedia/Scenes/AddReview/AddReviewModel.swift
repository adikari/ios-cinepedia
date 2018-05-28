//
//  AddReviewModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum AddReviewModel {
    enum AddReview {
        struct Request {
            var review: ViewModel.Review
            var movieId: Int
        }
        
        struct Response {
            var success: Bool
        }
        
        struct ViewModel {
            struct Review {
                var author: String
                var content: String
            }
            
            var review: Review
        }
    }
}
