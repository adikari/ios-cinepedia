//
//  MoviesWorker.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

class MoviesWorker {
    
    var moviesStore: MoviesStoreProtocol
    
    init(moviesStore: MoviesStoreProtocol) {
        self.moviesStore = moviesStore
    }
    
}

