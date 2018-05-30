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
    func setFavourite(request: MovieDetailModel.SetFavourite.Request)
    func isFavourite(request: MovieDetailModel.FetchFavourite.Request)
}

protocol MovieDetailDataStore {
    var movieId: Int? { get set }
    var movie: MovieDetail? { get }
}

class MovieDetailInteractor: MovieDetailDataStore, MovieDetailBusinessLogic {
    var movie: MovieDetail?
    var movieId: Int?
    
    var moviesWorker = MoviesWorker(moviesStore: MoviesApiStore())
    var favouriteWorker = FavouriteMovieWorker(store: FavouriteCoreDataStore())
    var presenter: MovieDetailPresentationLogic?

    func fetchMovieDetail(request: MovieDetailModel.FetchMovieDetail.Request) {
        moviesWorker.fetchMovie(movieId: request.movieId) { movie in
            let response = MovieDetailModel.FetchMovieDetail.Response(movie: movie)
            
            self.presenter?.displayMovie(response: response)
        }
    }
    
    func isFavourite(request: MovieDetailModel.FetchFavourite.Request) {
        favouriteWorker.isFavourite(movieId: request.movieId) { isFavourite in
            let response = MovieDetailModel.FetchFavourite.Response(isFavourite: isFavourite)
            
            self.presenter?.displayFavourite(response: response)
        }
    }
    
    func setFavourite(request: MovieDetailModel.SetFavourite.Request) {
        let response = MovieDetailModel.FetchFavourite.Response(isFavourite: !request.isFavourite)
        
        if (request.isFavourite) {
            favouriteWorker.setFavourite(movieId: request.movieId) {
                self.presenter?.displayFavourite(response: response)
            }
        } else {
            favouriteWorker.removeFavourite(movieId: request.movieId) {
                self.presenter?.displayFavourite(response: response)
            }
        }
        
    }
}
