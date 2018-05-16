//
//  MovieDetailInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol MovieDetailBusinessLogic {
    func fetchMovieDetail(request: MovieDetailModel.FetchMovieDetail.Request)
}

protocol MovieDetailDataStore {
    var movieId: Int? { get set }
    var movie: MovieDetail? { get }
}

class MovieDetailInteractor: MovieDetailDataStore, MovieDetailBusinessLogic {
    var movie: MovieDetail?
    var movieId: Int?
    
    var moviesWorker = MoviesWorker(moviesStore: MoviesApiStore())
    var presenter: MovieDetailPresentationLogic?

    func fetchMovieDetail(request: MovieDetailModel.FetchMovieDetail.Request) {
        moviesWorker.fetchMovie(movieId: request.movieId) { movie in
            self.movie = movie
            let response = MovieDetailModel.FetchMovieDetail.Response(movie: movie)
            
            self.presenter?.displayMovie(response: response)
        }
    }
}
