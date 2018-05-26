//
//  CastsModel.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

enum CastsModel {
    enum FetchCasts {
        struct Request {
            var movieId: Int
        }
        
        struct Response {
            var casts: [Cast]
        }
        
        struct ViewModel {
            struct Cast {
                var name: String
                var character: String
                var imageUrl: String
            }
            
            var casts: [Cast]
        }
    }
}
