//
//  CastWorker.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum ReviewStoreError: Equatable, Error {
    case CannotAdd(String)
    case CannotFetch(String)
    case CannotEncode(String)
}

protocol ReviewStoreProtocol {
    func fetchReviews(movieId: Int, completionHandler: @escaping ([Review], ReviewStoreError?) -> Void)
    func addReview(movieId: Int, review: Review, completionHandler: @escaping (Bool, ReviewStoreError?) -> Void)
}

class ReviewWorker {
    
    var reviewStore: ReviewStoreProtocol
    
    init(reviewStore: ReviewStoreProtocol) {
        self.reviewStore = reviewStore
    }
    
    func fetchReviews(movieId: Int, completionHandler: @escaping([Review]) -> Void) {
        reviewStore.fetchReviews(movieId: movieId) { reviews, error in
            DispatchQueue.main.async {
                completionHandler(reviews)
            }
        }
    }
    
    func addReview(movieId: Int, review: Review, completionHandler: @escaping(Bool) -> Void) {
        reviewStore.addReview(movieId: movieId, review: review) { success, error in
            DispatchQueue.main.async {
                completionHandler(success)
            }
        }
    }
}
