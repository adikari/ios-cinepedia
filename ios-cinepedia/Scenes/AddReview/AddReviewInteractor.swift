//
//  AddReviewInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol AddReviewBusinessLogic {
    func addReview(request: AddReviewModel.AddReview.Request)
}

protocol AddReviewDataStore {
    var movieId: Int? { get set }
}

class AddReviewInteractor: AddReviewDataStore, AddReviewBusinessLogic {
    var movieId: Int?
    
    var presenter: AddReviewPresentationLogic?
    var reviewWorker = ReviewWorker(reviewStore: ReviewCoreDataStore())
    
    func addReview(request: AddReviewModel.AddReview.Request) {
        let reviewToCreate = Review(
            author: request.review.author,
            content: request.review.content
        )
        
        reviewWorker.addReview(movieId: request.movieId, review: reviewToCreate) { success in
            let response = AddReviewModel.AddReview.Response(success: success)
            self.presenter?.displayMessage(response: response)
        }
    }
}
