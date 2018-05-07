//
//  ListMoviesInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol PopularMoviesBusinessLogic {
    func fetchFeaturedMovie(request: PopularMovies.Request)
}

class PopularMoviesInteractor: PopularMoviesBusinessLogic {
    var presenter: PopularMoviesPresentationLogic?
    var moviesWorker = MoviesWorker(moviesStore: MoviesApiStore())
    
    func fetchFeaturedMovie(request: PopularMovies.Request) {
        moviesWorker.fetchPopularMovies() { result in
            let movies = Array(result.prefix(request.numberOfMovies))
            let response = PopularMovies.Response(movies: movies)
            
            self.presenter?.displayFeaturedMovie(response: response)
        }
    }
}
