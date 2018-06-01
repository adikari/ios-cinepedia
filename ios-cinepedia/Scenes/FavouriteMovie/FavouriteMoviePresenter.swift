//
//  FavouriteMoviePresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 31/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol FavouriteMoviePresentationLogic {
    func displayFavouriteMovies(response: FavouriteMovieModel.FetchFavouriteMovies.Response)
}

class FavouriteMoviePresenter: FavouriteMoviePresentationLogic {
    
    var viewController: FavouriteMovieViewController?
    
    func displayFavouriteMovies(response: FavouriteMovieModel.FetchFavouriteMovies.Response) {
        
        var fetchedMovies: [FavouriteMovieModel.FetchFavouriteMovies.ViewModel.Movie] = []
        
        for movie in response.movies {
            if let imageUrl = movie.image() {
                let movieModel = FavouriteMovieModel.FetchFavouriteMovies.ViewModel.Movie(
                    id: movie.id,
                    title: movie.title,
                    imageUrl: imageUrl,
                    description: movie.description
                )
                
                fetchedMovies.append(movieModel)
            }
        }
        
        let viewModel = FavouriteMovieModel.FetchFavouriteMovies.ViewModel(movies: fetchedMovies)
        viewController?.displayFavouriteMovies(viewModel: viewModel)
    }
}
