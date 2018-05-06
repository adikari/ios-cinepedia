//
//  ios_cinepediaTests.swift
//  ios-cinepediaTests
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import Nimble
import Quick
import OHHTTPStubs
@testable import Moya
@testable import ios_cinepedia

class MovieApiStoreTests: QuickSpec {
    override func spec() {
        var store: MoviesApiStore!
        
        beforeEach {
            let provider = MoyaProvider<MovieService>(stubClosure: MoyaProvider.immediatelyStub)
            store = MoviesApiStore(provider: provider)
        }
        
        it("returns stubbed data for movies request") {
            store.fetchNowPlaying { movies, error in
                expect(movies[0].title).to(equal("Avengers: Infinity War"));
                expect(movies[0].image(width: 200, height: 100)).to(equal("https://image.tmdb.org/t/p/w200_and_h100_face/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg"));
                expect(movies[0].image()).to(equal("https://image.tmdb.org/t/p/w1000_and_h563_face/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg"));
            }

        }
        
        it("should return movie by id") {
            store.fetchMovie(movieId: 1) { movie, error in
                if let title = movie?.title {
                    expect(title).to(equal("Finding Nemo"));
                }
            }
        }
    }
   
}
