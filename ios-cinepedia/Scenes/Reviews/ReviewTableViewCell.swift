//
//  ReviewTableViewCell.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

class ReviewTableViewCell : UITableViewCell {
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var content: UILabel!
    
    func initialize(review: ReviewModel.FetchReview.ViewModel.Review) {
        author.text = review.author
        content.text = review.content
    }
}
