//
//  MovieDetailPresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol MovieDetailPresentationLogic {
    func fetchMovieDetail(response: MovieDetailModel.FetchMovieDetail.Response)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    var viewController: MovieDetailViewController?
    
    func fetchMovieDetail(response: MovieDetailModel.FetchMovieDetail.Response) {
        
    }
}
