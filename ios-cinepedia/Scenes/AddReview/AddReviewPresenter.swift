//
//  AddReviewPresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol AddReviewPresentationLogic {
    func displayMessage(response: AddReviewModel.AddReview.Response)
}

class AddReviewPresenter: AddReviewPresentationLogic {
    var viewController: AddReviewViewController?
    
    func displayMessage(response: AddReviewModel.AddReview.Response) {
        viewController?.displayMessage(success: response.success)
    }
}
