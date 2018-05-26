//
//  CastApiStore.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import Moya

class CastApiStore: CastStoreProtocol {
    
    let provider: MoyaProvider<CastService>
    
    init() {
        provider = MoyaProvider<CastService>()
    }
    
    func fetchCasts(movieId: Int, completionHandler: @escaping ([Cast], CastStoreError?) -> Void) {
        provider.request(.fetchCasts(movieId: movieId)) { result in
            switch result {
            case let .success(response):
                do {
                    let casts: [Cast] = try response.map([Cast].self, atKeyPath: "cast", using: JSONDecoder(), failsOnEmptyData: false)
                    
                    completionHandler(casts, nil)
                } catch {
                    completionHandler([], CastStoreError.CannotEncode(error.localizedDescription))
                }
            case let .failure(error):
                completionHandler([], CastStoreError.CannotFetch(error.localizedDescription))
            }
        }
    }
}

enum CastService {
    case fetchCasts(movieId: Int)
}

extension CastService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
    
    var path: String {
        switch self {
        case .fetchCasts(let movieId):
            return "/\(movieId)/credits"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCasts:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case let .fetchCasts(movieId):
            return .requestParameters(parameters: ["movie_id": movieId, "api_key": Constants.API_KEY], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [ "Content-type": "application/json" ]
    }
}
