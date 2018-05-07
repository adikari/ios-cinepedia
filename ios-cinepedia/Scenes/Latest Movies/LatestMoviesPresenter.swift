//
//  LatestMoviesPresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 7/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol LatestMoviesPresentationLogic {
    func displayLatestMovies(response: LatestMovies.Response)
}

class LatestMoviesPresenter: LatestMoviesPresentationLogic {
    
    var viewController: LatestMoviesViewController?
    
    func displayLatestMovies(response: LatestMovies.Response) {
        var fetchedMovies: [LatestMovies.ViewModel.Movie] = []
        
        let movies = Array(response.movies.prefix(15))
        
        for movie in movies {
            if let imageUrl = movie.image() {
                let latestMovie = LatestMovies.ViewModel.Movie(
                    imageUrl: imageUrl,
                    title: movie.title,
                    rating: movie.rating.description
                )
                
                fetchedMovies.append(latestMovie)
            }
        }
        
        let viewModel = LatestMovies.ViewModel(movies: fetchedMovies)
        
        viewController?.displayLatestMovies(viewModel: viewModel)
    }
}
