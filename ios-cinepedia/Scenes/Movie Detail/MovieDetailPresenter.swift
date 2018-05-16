//
//  MovieDetailPresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol MovieDetailPresentationLogic {
    func displayMovie(response: MovieDetailModel.FetchMovieDetail.Response)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    var viewController: MovieDetailViewController?
    
    func displayMovie(response: MovieDetailModel.FetchMovieDetail.Response) {
        if let fetchedMovie = response.movie {
            let movie = MovieDetailModel.FetchMovieDetail.ViewModel.Movie(
                id: fetchedMovie.id,
                title: fetchedMovie.title,
                description: fetchedMovie.description
            )
            
            let viewModel = MovieDetailModel.FetchMovieDetail.ViewModel.init(movie: movie)
            
            viewController?.displayMovie(viewModel: viewModel)
        }
    }
}
