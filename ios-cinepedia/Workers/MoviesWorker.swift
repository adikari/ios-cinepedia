//
//  MoviesWorker.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

class MoviesWorker {
    
    var moviesStore: MoviesStoreProtocol
    
    init(moviesStore: MoviesStoreProtocol) {
        self.moviesStore = moviesStore
    }
    
    func fetchNowPlayingMovies(completionHandler: @escaping ([Movie]) -> Void) {
        moviesStore.fetchNowPlaying { movies, error in
            DispatchQueue.main.async {
                completionHandler(movies)
            }
        }
    }
    
    func fetchPopularMovies(completionHandler: @escaping([Movie]) -> Void) {
        moviesStore.fetchPopular { movies, error in
            DispatchQueue.main.async {
                completionHandler(movies)
            }
        }
    }
    
    func fetchUpcomingMovies(completionHandler: @escaping([Movie]) -> Void) {
        moviesStore.fetchUpcoming { movies, error in
            DispatchQueue.main.async {
                completionHandler(movies)
            }
        }
    }
    
    func fetchFeaturedMovie(completionHandler: @escaping(Movie?) -> Void) {
        // TODO: get featured movie
        moviesStore.fetchMovie(movieId: 12) { movie, error in
            DispatchQueue.main.async {
                completionHandler(movie)
            }
        }
    }
}

