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
    
    func fetchMovieDetail(movieId: Int, completionHandler: @escaping (Movie, MovieStoreError) -> Void) {
    }
    
    func fetchNowPlaying(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void) {
        fetchMovies(.fetchNowPlaying) { movies, error in
            completionHandler(movies, error)
        }
    }
    
    func fetchPopular(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void) {
        fetchMovies(.fetchPopular) { movies, error in
            completionHandler(movies, error)
        }
    }
    
    func fetchUpcoming(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void) {
        fetchMovies(.fetchUpcoming) { movies, error in
            completionHandler(movies, error)
        }
    }
    
    func fetchToprated(completionHandler: @escaping ([Movie], MovieStoreError?) -> Void) {
        fetchMovies(.fetchToprated) { movies, error in
            completionHandler(movies, error)
        }
    }
    
    func fetchMovie(movieId: Int, completionHandler: @escaping (MovieDetail?, MovieStoreError?) -> Void) {
        provider.request(.fetchMovie(movieId: movieId)) { result in
            switch result {
            case let .success(response):
                do {
                    let movie: MovieDetail = try response.map(MovieDetail.self)
                    completionHandler(movie, nil)
                } catch {
                    completionHandler(nil, MovieStoreError.CannotEncode(error.localizedDescription))
                }
            case let .failure(error):
                completionHandler(nil, MovieStoreError.CannotFetch(error.errorDescription!))
            }
        }
    }
    
    private func fetchMovies(_ endpoint: MovieService, completionHandler: @escaping([Movie], MovieStoreError?) -> Void) {
        provider.request(endpoint) { result in
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
}

enum MovieService {
    case fetchNowPlaying
    case fetchPopular
    case fetchUpcoming
    case fetchMovie(movieId: Int)
    case fetchToprated
}

extension MovieService: TargetType {

    var sampleData: Data {
        switch self {
        case .fetchNowPlaying:
            return mockMovies.utf8Encoded
        case .fetchPopular:
            return mockMovies.utf8Encoded
        case .fetchUpcoming:
            return mockMovies.utf8Encoded
        case .fetchToprated:
            return mockMovies.utf8Encoded
        case .fetchMovie(_):
            return mockMovie.utf8Encoded
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
        case .fetchToprated:
            return "/top_rated"
        case .fetchMovie(let movieId):
            return "/\(movieId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchToprated, .fetchUpcoming, .fetchPopular,
             .fetchNowPlaying, .fetchMovie:
                return .get
        }
    }

    var task: Task {
        switch self {
            case .fetchToprated, .fetchUpcoming, .fetchPopular, .fetchNowPlaying:
                return .requestParameters(parameters: ["api_key": Constants.API_KEY], encoding: URLEncoding.queryString)
        case let .fetchMovie(movieId):
            return .requestParameters(parameters: ["movie_id": movieId, "api_key": Constants.API_KEY], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [ "Content-type": "application/json" ]
    }
}

private let mockMovie = """
{
"adult": false,
"backdrop_path": "/n2vIGWw4ezslXjlP0VNxkp9wqwU.jpg",
"belongs_to_collection": {
"id": 137697,
"name": "Finding Nemo Collection",
"poster_path": "/xwggrEugjcJDuabIWvK2CpmK91z.jpg",
"backdrop_path": "/2hC8HHRUvwRljYKIcQDMyMbLlxz.jpg"
},
"budget": 94000000,
"genres": [
{
"id": 16,
"name": "Animation"
},
{
"id": 10751,
"name": "Family"
}
],
"homepage": "http://movies.disney.com/finding-nemo",
"id": 12,
"imdb_id": "tt0266543",
"original_language": "en",
"original_title": "Finding Nemo",
"overview": "Nemo, an adventurous young clownfish",
"popularity": 25.78404,
"poster_path": "/syPWyeeqzTQIxjIUaIFI7d0TyEY.jpg",
"production_companies": [
{
"id": 3,
"logo_path": "/1TjvGVDMYsj6JBxOAkUHpPEwLf7.png",
"name": "Pixar",
"origin_country": "US"
}
],
"production_countries": [
{
"iso_3166_1": "US",
"name": "United States of America"
}
],
"release_date": "2003-05-30",
"revenue": 940335536,
"runtime": 100,
"spoken_languages": [
{
"iso_639_1": "en",
"name": "English"
}
],
"status": "Released",
"tagline": "There are 3.7 trillion fish in the ocean. They're looking for one.",
"title": "Finding Nemo",
"video": false,
"vote_average": 7.7,
"vote_count": 8311
}
"""

private let mockMovies = """
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
