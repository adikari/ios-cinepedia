//
//  MovieDetailRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol MovieDetailRouterLogic {
}

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get }
}

class MovieDetailRouter: NSObject, MovieDetailRouterLogic, MovieDetailDataPassing {
    var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?
}
