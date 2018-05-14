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

protocol LatestMoviesDataStore {
    var movies: [Movie]? { get }
}

class LatestMoviesInteractor : LatestMoviesBusinessLogic, LatestMoviesDataStore {
    var presenter: LatestMoviesPresentationLogic?
    var moviesWorker = MoviesWorker(moviesStore: MoviesApiStore())
    var movies: [Movie]?
    
    func fetchLatestMovies(request: LatestMovies.Request) {
        moviesWorker.fetchUpcomingMovies() { movies in
            self.movies = movies
            let response = LatestMovies.Response(movies: movies)

            self.presenter?.displayLatestMovies(response: response)
        }
    }
}
