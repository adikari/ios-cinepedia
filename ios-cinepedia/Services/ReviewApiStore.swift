//
//  CastApiStore.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import Moya

class ReviewApiStore: ReviewStoreProtocol {
    
    let provider: MoyaProvider<ReviewService>
    
    init() {
        provider = MoyaProvider<ReviewService>()
    }
    
    func fetchReviews(movieId: Int, completionHandler: @escaping ([Review], ReviewStoreError?) -> Void) {
        provider.request(.fetchReviews(movieId: movieId)) { result in
            switch result {
            case let .success(response):
                do {
                    let reviews: [Review] = try response.map([Review].self, atKeyPath: "results", using: JSONDecoder(), failsOnEmptyData: false)
                    completionHandler(reviews, nil)
                } catch {
                    completionHandler([], ReviewStoreError.CannotEncode(error.localizedDescription))
                }
            case let .failure(error):
                completionHandler([], ReviewStoreError.CannotFetch(error.localizedDescription))
            }
        }
    }

}

enum ReviewService {
    case fetchReviews(movieId: Int)
}

extension ReviewService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
    
    var path: String {
        switch self {
        case .fetchReviews(let movieId):
            return "/\(movieId)/reviews"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchReviews:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case let .fetchReviews(movieId):
            return .requestParameters(parameters: ["movie_id": movieId, "api_key": Constants.API_KEY], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [ "Content-type": "application/json" ]
    }
}
