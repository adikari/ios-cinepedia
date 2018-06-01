//
//  FavouriteMovieRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 31/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation


import Foundation
import UIKit

@objc protocol FavouriteMovieRouterLogic {
    func routeToMovieDetail(segue: UIStoryboardSegue?)
}

protocol FavouriteMovieDataPassing {
    var dataStore: FavouriteMovieDataStore? { get }
}

class FavouriteMovieRouter: NSObject, FavouriteMovieRouterLogic, FavouriteMovieDataPassing {
    weak var viewController: FavouriteMovieViewController?
    var dataStore: FavouriteMovieDataStore?
    
    // MARK: Routing
    
    func routeToMovieDetail(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! MovieDetailViewController
            
            var destinationDS = destinationVC.router?.dataStore
            
            passDataToMovieDetail(source: dataStore!, dest: &destinationDS!)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            
            passDataToMovieDetail(source: dataStore!, dest: &destinationDS)
            navigateToMovieDetail(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Pass Data
    
    func passDataToMovieDetail(source: FavouriteMovieDataStore, dest: inout MovieDetailDataStore) {
        let selectedRow = viewController?.favouritesTableView.indexPathForSelectedRow?.row
        dest.movieId = source.movies?[selectedRow!].id
    }

    // MARK: Navigation
    
    func navigateToMovieDetail(source: FavouriteMovieViewController, destination: MovieDetailViewController) {
        source.show(destination, sender: nil)
    }
}
