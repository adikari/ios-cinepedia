//
//  CastWorker.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum CastStoreError: Equatable, Error {
    case CannotFetch(String)
    case CannotEncode(String)
}

protocol CastStoreProtocol {
    func fetchCasts(movieId: Int, completionHandler: @escaping ([Cast], CastStoreError?) -> Void)
}

class CastWorker {
    
    var castStore: CastStoreProtocol
    
    init(castStore: CastStoreProtocol) {
        self.castStore = castStore
    }
    
    func fetchCasts(movieId: Int, completionHandler: @escaping([Cast]) -> Void) {
        castStore.fetchCasts(movieId: movieId) { casts, error in
            DispatchQueue.main.async {
                completionHandler(casts)
            }
        }
    }
}
