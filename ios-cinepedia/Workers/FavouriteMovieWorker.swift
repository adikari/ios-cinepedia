//
//  FavouriteMovieWorker.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 30/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum FavouriteStoreError: Equatable, Error {
    case CannotFetch(String)
    case CannotEncode(String)
    case CannotUpdate(String)
    case CannotCreate(String)
}

protocol FavouriteStoreProtocol {
    func setFavourite(movieId: Int, completionHandler: @escaping (FavouriteStoreError?) -> Void)
    func removeFavourite(movieId: Int, completionHandler: @escaping(FavouriteStoreError?) -> Void)
    func isFavourite(movieId: Int, completionHandler: @escaping(Bool, FavouriteStoreError?) -> Void)
}

class FavouriteMovieWorker {
    
    var store: FavouriteStoreProtocol
    
    init(store: FavouriteStoreProtocol) {
        self.store = store
    }
    
    func isFavourite(movieId: Int, completionHandler: @escaping(Bool) -> Void) {
        store.isFavourite(movieId: movieId) { isFavourite, error in
            DispatchQueue.main.async {
                completionHandler(isFavourite)
            }
        }
    }
    
    func setFavourite(movieId: Int, completionHandler: @escaping () -> Void) {
        store.setFavourite(movieId: movieId) { error in
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    func removeFavourite(movieId: Int, completionHandler: @escaping() -> Void) {
        store.setFavourite(movieId: movieId) { error in
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}
