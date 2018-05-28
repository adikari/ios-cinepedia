//
//  ReviewInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol ReviewBusinessLogic {
    func fetchReview(request: ReviewModel.FetchReview.Request)
}

protocol ReviewDataStore {
    var movieId: Int? { get set }
    var reviews: [Review] { get }
}

class ReviewInteractor: ReviewDataStore, ReviewBusinessLogic {
    var reviews = [Review]()
    var movieId: Int?
    
    var reviewWorker = ReviewWorker(reviewStore: ReviewApiStore())
    var reviewCDWorker = ReviewWorker(reviewStore: ReviewCoreDataStore())
    var presenter: ReviewPresentationLogic?
    
    func fetchReview(request: ReviewModel.FetchReview.Request) {

        // TODO: Improve this. Potentially promise
        reviewCDWorker.fetchReviews(movieId: request.movieId) { cdReviews in
            self.reviewWorker.fetchReviews(movieId: request.movieId) { reviews in
                self.reviews = cdReviews + reviews
                
                let response = ReviewModel.FetchReview.Response(reviews: self.reviews)
                self.presenter?.displayReview(response: response)
            }
        }
    }
}


