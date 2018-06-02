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
            let movieModel = FavouriteMovieModel.FetchFavouriteMovies.ViewModel.Movie(
                id: movie.id,
                title: movie.title,
                imageUrl: getImageUrl(movie.imageUrl),
                description: movie.description
            )

            fetchedMovies.append(movieModel)
        }
        
        let viewModel = FavouriteMovieModel.FetchFavouriteMovies.ViewModel(movies: fetchedMovies)
        
        viewController?.displayFavouriteMovies(viewModel: viewModel)
    }
    
    // TODO: perform this using regex later
    private func getImageUrl(_ imageUrl: String) -> String {
        let result = imageUrl.replacingOccurrences(of: "w500", with: "w370")
        
        return result.replacingOccurrences(of: "_h282", with: "_h556")
    }
}
