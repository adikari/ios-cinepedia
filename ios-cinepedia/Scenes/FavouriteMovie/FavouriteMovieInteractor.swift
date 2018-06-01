//
//  FavouriteMovieInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 31/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol FavouriteMovieBusinessLogic {
    func fetchFavouriteMovies(request: FavouriteMovieModel.FetchFavouriteMovies.Request)
}

protocol FavouriteMovieDataStore {
    var movies: [FavouriteMovie]? { get }
}

class FavouriteMovieInteractor: FavouriteMovieBusinessLogic, FavouriteMovieDataStore {
    var presenter: FavouriteMoviePresentationLogic?
    var moviesWorker = FavouriteMovieWorker(store: FavouriteCoreDataStore())
    var movies: [FavouriteMovie]?
    
    func fetchFavouriteMovies(request: FavouriteMovieModel.FetchFavouriteMovies.Request) {
        moviesWorker.fetchFavouriteMovies() { movies in
            self.movies = movies
            let response = FavouriteMovieModel.FetchFavouriteMovies.Response(movies: movies)
            
            self.presenter?.displayFavouriteMovies(response: response)
        }
    }
}
