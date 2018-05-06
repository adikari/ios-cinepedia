//
//  ListMoviesPresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol ListMoviesPresentationLogic {
    func displayFeaturedMovie(response: ListMovies.Featured.Response)
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
    var viewController: MainViewController?
    
    func displayFeaturedMovie(response: ListMovies.Featured.Response) {
        if let movie = response.movie, let imageUrl = movie.image() {
            let featuredMovie = ListMovies.Featured.ViewModel.FeaturedMovie(imageUrl: imageUrl, title: movie.title)
            let viewModel = ListMovies.Featured.ViewModel(featuredMovie: featuredMovie)
            
            viewController?.displayFeaturedMovie(viewModel: viewModel)
        }
        
    }
}
