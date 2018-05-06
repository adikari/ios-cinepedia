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
            }

        }
        
        it("should return movie by id") {
            store.fetchMovie(movieId: 1) { movie, error in
                if title = movie?.title {
                    expect(title).to(equal("Finding Nemo"));
                }
            }
        }
    }
   
}
