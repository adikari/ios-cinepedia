//
//  FavouriteTableViewCell.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 1/6/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    func initialize(movie: FavouriteMovieModel.FetchFavouriteMovies.ViewModel.Movie) {
        title.text = movie.title
        desc.text = movie.description
        
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(with: URL(string: movie.imageUrl))
    }
}
