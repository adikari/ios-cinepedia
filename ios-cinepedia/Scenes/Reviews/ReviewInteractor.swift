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
    
    var workers = [
        ReviewWorker(reviewStore: ReviewApiStore()),
        ReviewWorker(reviewStore: ReviewCoreDataStore())
    ]
    
    var presenter: ReviewPresentationLogic?
    
    func fetchReview(request: ReviewModel.FetchReview.Request) {
        let group = DispatchGroup()
        
        for worker in workers {
            group.enter()
            worker.fetchReviews(movieId: request.movieId) { reviews in
                self.reviews.append(contentsOf: reviews)
                group.leave()
            }
        }
       
        group.notify(queue: .main) { [weak self] in
            let response = ReviewModel.FetchReview.Response(reviews: (self?.reviews)!)
            self?.presenter?.displayReview(response: response)
        }
    }
}


