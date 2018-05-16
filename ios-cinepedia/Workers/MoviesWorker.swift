//
//  MoviesWorker.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol MoviesStoreProtocol {
    func fetchNowPlaying(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void)
    func fetchPopular(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void)
    func fetchUpcoming(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void)
    func fetchMovie(movieId: Int, completionHandler: @escaping (Movie?, MovieStoreError?) -> Void)
    func fetchToprated(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void)
}


enum MovieStoreError: Equatable, Error {
    case CannotFetch(String)
    case CannotEncode(String)
}

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
    
    func fetchTopratedMovies(completionHandler: @escaping([Movie]) -> Void) {
        moviesStore.fetchToprated { movies, error in
            DispatchQueue.main.async {
                completionHandler(movies)
            }
        }
    }
    
    func fetchMovie(movieId: Int, completionHandler: @escaping(Movie?) -> Void) {
        moviesStore.fetchMovie(movieId: movieId) { movie, error in
            DispatchQueue.main.async {
                if let movie = movie {
                    completionHandler(movie)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
}
