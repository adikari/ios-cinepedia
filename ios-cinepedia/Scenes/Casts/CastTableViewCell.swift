//
//  CastTableViewCell.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var character: UILabel!
    @IBOutlet weak var castImage: UIImageView!
    
    func initialize(cast: CastsModel.FetchCasts.ViewModel.Cast) {
        name.text = cast.name
        character.text = cast.character
        
        castImage.kf.indicatorType = .activity
        castImage.kf.setImage(with: URL(string: cast.imageUrl))
    }
}
