//
//  LatestMoviesInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 7/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol LatestMoviesBusinessLogic {
    func fetchLatestMovies(request: LatestMovies.Request)
}

class LatestMoviesInteractor : LatestMoviesBusinessLogic {
    
    var presenter: LatestMoviesPresentationLogic?
    var moviesWorker = MoviesWorker(moviesStore: MoviesApiStore())
    
    func fetchLatestMovies(request: LatestMovies.Request) {
        moviesWorker.fetchPopularMovies() { movies in
            let response = LatestMovies.Response(movies: movies)
            
            self.presenter?.displayLatestMovies(response: response)
        }
    }
}
