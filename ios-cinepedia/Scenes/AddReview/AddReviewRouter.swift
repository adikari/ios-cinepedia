//
//  AddReviewRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

@objc protocol AddReviewRouterLogic { }

protocol AddReviewDataPassing {
    var dataStore: AddReviewDataStore? { get set }
}

class AddReviewRouter: NSObject, AddReviewRouterLogic, AddReviewDataPassing {
    weak var viewController: AddReviewViewController?
    var dataStore: AddReviewDataStore?
}
