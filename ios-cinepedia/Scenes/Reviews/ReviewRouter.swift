//
//  ReviewRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

@objc protocol ReviewRouterLogic {
    func routeToAddReview(segue: UIStoryboardSegue?)
}

protocol ReviewDataPassing {
    var dataStore: ReviewDataStore? { get }
}

class ReviewRouter: NSObject, ReviewRouterLogic, ReviewDataPassing {

    weak var viewController: ReviewViewController?
    var dataStore: ReviewDataStore?
    
    func routeToAddReview(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! AddReviewViewController
            var destinationDS = destinationVC.router?.dataStore

            if let movieId = viewController?.router?.dataStore?.movieId {
                destinationDS?.movieId = movieId
            }
        }
    }
}
