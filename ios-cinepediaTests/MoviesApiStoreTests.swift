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
            // var message: String?
            
            store.fetchNowPlaying { movies, error in
               print(movies)
            }

//            let target: GitHub = .zen
//            provider.request(target) { result in
//                if case let .success(response) = result {
//                    message = String(data: response.data, encoding: .utf8)
//                }
//            }
//
//            let sampleData = target.sampleData
//            expect(message).to(equal(String(data: sampleData, encoding: .utf8)))
        }
    }
    
}
