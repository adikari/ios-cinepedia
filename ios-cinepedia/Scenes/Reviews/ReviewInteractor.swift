//
//  CastsInteractor.swift
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
    var review: [Cast]? { get }
}

class ReviewInteractor: ReviewDataStore, ReviewBusinessLogic {
    var review: [Cast]?
    var movieId: Int?
    
    var reviewWorker = CastWorker(castStore: CastApiStore())
    var presenter: ReviewPresentationLogic?
    
    func fetchReview(request: ReviewModel.FetchReview.Request) {
    }
}


