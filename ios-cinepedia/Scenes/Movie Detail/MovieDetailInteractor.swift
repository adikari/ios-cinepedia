//
//  MovieDetailInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol MovieDetailBusinessLogic {
    
}

protocol MovieDetailDataStore {
    var movieId: Int? { get set }
}

class MovieDetailInteractor: MovieDetailDataStore, MovieDetailBusinessLogic {
    var presenter: MovieDetailPresentationLogic?
    var movieId: Int?
}
