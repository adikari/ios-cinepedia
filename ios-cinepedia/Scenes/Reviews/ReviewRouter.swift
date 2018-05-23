//
//  ReviewRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol ReviewRouterLogic { }

protocol ReviewDataPassing {
    var dataStore: ReviewDataStore? { get }
}

class ReviewRouter: NSObject, ReviewRouterLogic, ReviewDataPassing {
    var viewController: ReviewViewController?
    var dataStore: ReviewDataStore?
}
