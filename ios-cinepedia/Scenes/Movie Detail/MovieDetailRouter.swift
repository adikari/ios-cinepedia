//
//  MovieDetailRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import UIKit

@objc protocol MovieDetailRouterLogic {
    func routeToReviews(segue: UIStoryboardSegue?)
    func routeToCasts(segue: UIStoryboardSegue?)
}

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get }
}

class MovieDetailRouter: NSObject, MovieDetailRouterLogic, MovieDetailDataPassing {
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?
    
    func routeToReviews(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ReviewViewController
            
            var destinationDS = destinationVC.router?.dataStore

            if let movieId = viewController?.router?.dataStore?.movieId {
                passDataToReview(dataStore: &destinationDS!, movieId: movieId)
            }
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
            var destinationDS = destinationVC.router!.dataStore!
            
            if let movieId = viewController?.router?.dataStore?.movieId {
                passDataToReview(dataStore: &destinationDS, movieId: movieId)
                navigateToReview(source: viewController!, destination: destinationVC)
            }
        }
        
    }
    
    func routeToCasts(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! CastsViewController
            
            var destinationDS = destinationVC.router?.dataStore
            
            if let movieId = viewController?.router?.dataStore?.movieId {
                passDataToCasts(dataStore: &destinationDS!, movieId: movieId)
            }
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "CastsViewController") as! CastsViewController
            var destinationDS = destinationVC.router!.dataStore!
            
            if let movieId = viewController?.router?.dataStore?.movieId {
                passDataToCasts(dataStore: &destinationDS, movieId: movieId)
                navigateToCasts(source: viewController!, destination: destinationVC)
            }
        }
    }
    
    func passDataToReview(dataStore: inout ReviewDataStore, movieId: Int) {
        dataStore.movieId = movieId
    }
    
    func passDataToCasts(dataStore: inout CastsDataStore, movieId: Int) {
        dataStore.movieId = movieId
    }
    
    func navigateToReview(source: MovieDetailViewController, destination: ReviewViewController) {
        source.show(destination, sender: nil)
    }
    
    func navigateToCasts(source: MovieDetailViewController, destination: CastsViewController) {
        source.show(destination, sender: nil)
    }
}
