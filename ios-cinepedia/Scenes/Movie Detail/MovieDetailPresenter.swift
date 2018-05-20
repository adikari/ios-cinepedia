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
            
            let tuple = minutesToHoursMinutes(minutes: fetchedMovie.runtime)
            
            let movie = MovieDetailModel.FetchMovieDetail.ViewModel.Movie(
                id: fetchedMovie.id,
                title: fetchedMovie.title,
                description: fetchedMovie.description,
                posterUrl: fetchedMovie.poster(),
                backdropUrl: fetchedMovie.backdrop(),
                runtime: "\(tuple.hours)H \(tuple.minutes)M",
                genres: fetchedMovie.genres.map { $0.name }.joined(separator: ", "),
                year: fetchedMovie.releaseDate.year,
                status: fetchedMovie.status,
                rating: fetchedMovie.rating.description
            )
            
            let viewModel = MovieDetailModel.FetchMovieDetail.ViewModel.init(movie: movie)
            
            viewController?.displayMovie(viewModel: viewModel)
        }
    }
    
    private func minutesToHoursMinutes (minutes : Int) -> (hours : Int , minutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
}
