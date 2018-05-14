//
//  LatestMoviesRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import UIKit

protocol LatestMoviesRouterLogic {
    func routeToMovieDetail(movie: LatestMovies.ViewModel.Movie)
}

protocol LatestMoviesDataPassing {
    var dataStore: LatestMoviesDataStore? { get }
}

class LatestMoviesRouter: NSObject, LatestMoviesRouterLogic, LatestMoviesDataPassing {
    weak var viewController: LatestMoviesViewController?
    var dataStore: LatestMoviesDataStore?
    
    // MARK: Routing
    
    func routeToMovieDetail(movie: LatestMovies.ViewModel.Movie) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        var destinationDS = destinationVC.router!.dataStore!

        destinationDS.movieId = movie.id
        navigateToMovieDetail(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToMovieDetail(source: LatestMoviesViewController, destination: MovieDetailViewController) {
        source.show(destination, sender: nil)
    }
}
