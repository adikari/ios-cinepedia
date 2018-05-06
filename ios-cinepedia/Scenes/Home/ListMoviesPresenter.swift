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
        var featuredMovies: [ListMovies.Featured.ViewModel.FeaturedMovie] = []
        
        for movie in response.movies {
            if let imageUrl = movie.image() {
                let featuredMovie = ListMovies.Featured.ViewModel.FeaturedMovie(imageUrl: imageUrl, title: movie.title)
                featuredMovies.append(featuredMovie)
            }
        }
        
        let viewModel = ListMovies.Featured.ViewModel(featuredMovies: featuredMovies)

        viewController?.displayFeaturedMovie(viewModel: viewModel)

    }
}
