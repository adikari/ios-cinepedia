//
//  CastPresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol ReviewPresentationLogic {
    func displayReview(response: ReviewModel.FetchReview.Response)
}

class ReviewPresenter: ReviewPresentationLogic {
    var viewController: ReviewViewController?
    
    func displayReview(response: ReviewModel.FetchReview.Response) {
        
    }
}
