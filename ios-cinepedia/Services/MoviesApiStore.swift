//
//  MoviesApiStore.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation
import Moya

class MoviesApiStore: MoviesStoreProtocol {
    
    let provider: MoyaProvider<MovieService>
    
    init() {
        provider = MoyaProvider<MovieService>()
    }
    
    init(provider: MoyaProvider<MovieService>) {
        self.provider = provider
    }
    
    func fetchNowPlaying(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void) {
        provider.request(.fetchNowPlaying) { result in
            switch result {
                case let .success(response):
                    do {
                        let movies: [Movie] = try response.map([Movie].self, atKeyPath: "results", using: JSONDecoder(), failsOnEmptyData: false)
                        completionHandler(movies, nil)
                    } catch {
                        completionHandler([], MovieStoreError.CannotEncode(error.localizedDescription))
                    }
                case let .failure(error):
                    completionHandler([], MovieStoreError.CannotFetch(error.errorDescription!))
            }
        }
    }
    
    func fetchPopular(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void) {
        provider.request(.fetchPopular) { result in
            
        }
    }
    
    func fetchUpcoming(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void) {
        provider.request(.fetchUpcoming) { result in
            
        }
    }
    
    func fetchMovie(movieId: Int, completionHandler: @escaping ([Movie], MovieStoreError?) -> Void) {
        provider.request(.fetchMovie(movieId: movieId)) { result in
            
        }
    }
}

enum MovieService {
    case fetchNowPlaying
    case fetchPopular
    case fetchUpcoming
    case fetchMovie(movieId: Int)
}

extension MovieService: TargetType {

    var sampleData: Data {
        switch self {
            case .fetchNowPlaying:
                return sampleMovieResult.utf8Encoded
            default:
                return "default".utf8Encoded
        }
    }

    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
    
    var path: String {
        switch self {
            case .fetchNowPlaying:
                return "/now_playing"
            case .fetchPopular:
                return "/popular"
            case .fetchUpcoming:
                return "/upcoming"
            case .fetchMovie(let movieId):
                return "/\(movieId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .fetchUpcoming, .fetchPopular, .fetchNowPlaying, .fetchMovie:
                return .get
        }
    }

    var task: Task {
        let apiKey: String = "78af8f82a9b6b6f6dbf3a39e60f38983"
        
        switch self {
            case .fetchUpcoming, .fetchPopular, .fetchNowPlaying:
                return .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.queryString)
        case let .fetchMovie(movieId):
            return .requestParameters(parameters: ["movie_id": movieId, "api_key": apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [ "Content-type": "application/json" ]
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

private let sampleMovieResult = """
{
    "results": [
    {
    "vote_count": 2418,
    "id": 299536,
    "video": false,
    "vote_average": 8.7,
    "title": "Avengers: Infinity War",
    "popularity": 700.87566,
    "poster_path": "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
    "original_language": "en",
    "original_title": "Avengers: Infinity War",
    "genre_ids": [
    12,
    878,
    14,
    28
    ],
    "backdrop_path": "/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg",
    "adult": false,
    "overview": "overview",
    "release_date": "2018-04-25"
    },
    {
    "vote_count": 409,
    "id": 427641,
    "video": false,
    "vote_average": 5.9,
    "title": "Rampage",
    "popularity": 181.959502,
    "poster_path": "/30oXQKwibh0uANGMs0Sytw3uN22.jpg",
    "original_language": "en",
    "original_title": "Rampage",
    "genre_ids": [
    28,
    12,
    878
    ],
    "backdrop_path": "/wrqUiMXttHE4UBFMhLHlN601MZh.jpg",
    "adult": false,
    "overview": "overview",
    "release_date": "2018-04-12"
    }
    ],
    "page": 1,
    "total_results": 933,
    "dates": {
        "maximum": "2018-05-11",
        "minimum": "2018-03-23"
    },
    "total_pages": 47
}
"""
