//
//  MoviesStoreProtocol.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol MoviesStoreProtocol {
    func fetchNowPlaying(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void)
    func fetchPopular(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void)
    func fetchUpcoming(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void)
    func fetchMovie(movieId: Int, completionHandler: @escaping ([Movie], MovieStoreError?) -> Void)
}

enum MovieStoreError: Equatable, Error
{
    case CannotFetch(String)
    case CannotEncode(String)
}
