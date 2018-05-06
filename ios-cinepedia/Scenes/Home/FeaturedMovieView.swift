//
//  FeaturedMovieView.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import Kingfisher

class FeaturedMovieView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func initialize(imageUrl: String, title: String) {
        imageView.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
    }
}
