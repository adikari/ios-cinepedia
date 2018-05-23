//
//  ReviewPresenter.swift
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
        var fetchedReviews: [ReviewModel.FetchReview.ViewModel.Review] = []
        
        let reviews = Array(response.reviews.prefix(15))
        
        for review in reviews {
            let reviewModel = ReviewModel.FetchReview.ViewModel.Review(
                author: review.author,
                content: review.content
            )
            
            fetchedReviews.append(reviewModel)
        }
        
        let viewModel = ReviewModel.FetchReview.ViewModel(reviews: fetchedReviews)
        viewController?.displayReview(viewModel: viewModel)
    }
}
