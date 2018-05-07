//
//  ListMoviesPresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol PopularMoviesPresentationLogic {
    func displayFeaturedMovie(response: PopularMovies.Response)
}

class PopularMoviesPresenter: PopularMoviesPresentationLogic {
    var viewController: PopularMoviesViewController?
    
    func displayFeaturedMovie(response: PopularMovies.Response) {
        var popularMovies: [PopularMovies.ViewModel.Movie] = []
        
        let movies = Array(response.movies.prefix(5))
        
        for movie in movies {
            if let imageUrl = movie.image() {
                let featuredMovie = PopularMovies.ViewModel.Movie(imageUrl: imageUrl, title: movie.title)
                popularMovies.append(featuredMovie)
            }
        }
        
        let viewModel = PopularMovies.ViewModel(movies: popularMovies)

        viewController?.displayPopularMovies(viewModel: viewModel)

    }
}
