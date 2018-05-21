//
//  MovieDetailView.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 15/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var desc: UILabel!

    func initialize(movie: MovieDetailModel.FetchMovieDetail.ViewModel.Movie) {
        movieTitle.text = movie.title
        year.text = movie.year
        runtime.text = movie.runtime
        genre.text = movie.genres
        rating.text = movie.rating
        desc.text = movie.description
        
        if let imageUrl = movie.backdropUrl {
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: URL(string: imageUrl))
        }
    }
}
