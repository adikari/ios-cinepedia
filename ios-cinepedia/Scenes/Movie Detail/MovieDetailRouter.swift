//
//  MovieDetailRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailRouterLogic {
    func routeToReviews(segue: UIStoryboardSegue?)
}

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get }
}

class MovieDetailRouter: NSObject, MovieDetailRouterLogic, MovieDetailDataPassing {
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?
    
    func routeToReviews(segue: UIStoryboardSegue?) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        
        // var destinationDS = destinationVC.router?.dataStore
        // destinationDS?.movieId = movie.id
        
        navigateToReview(source: viewController!, destination: destinationVC)
    }
    
    func routeToCasts(segue: UIStoryboardSegue?) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "CastsViewController") as! CastsViewController
        
        // var destinationDS = destinationVC.router?.dataStore
        // destinationDS?.movieId = movie.id
        
        navigateToCasts(source: viewController!, destination: destinationVC)
    }
    
    func navigateToReview(source: MovieDetailViewController, destination: ReviewViewController) {
        source.show(destination, sender: nil)
    }
    
    func navigateToCasts(source: MovieDetailViewController, destination: CastsViewController) {
        source.show(destination, sender: nil)
    }
}
