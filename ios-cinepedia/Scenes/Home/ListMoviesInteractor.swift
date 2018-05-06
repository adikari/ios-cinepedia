//
//  ListMoviesInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol ListMoviesBusinessLogic {
    func fetchFeaturedMovie(request: ListMovies.Featured.Request)
}

class ListMoviesInteractor: ListMoviesBusinessLogic {
    var presenter: ListMoviesPresentationLogic?
    var moviesWorker = MoviesWorker(moviesStore: MoviesApiStore())
    
    func fetchFeaturedMovie(request: ListMovies.Featured.Request) {
        moviesWorker.fetchFeaturedMovie() { movie in
            let response = ListMovies.Featured.Response(movie: movie)
            
            self.presenter?.displayFeaturedMovie(response: response)
        }
    }
}
