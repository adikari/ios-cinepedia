//
//  CastsInteractor.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol CastsBusinessLogic {
    func fetchCasts(request: CastsModel.FetchCasts.Request)
}

protocol CastsDataStore {
    var movieId: Int? { get set }
    var casts: [Cast]? { get }
}

class CastsInteractor: CastsDataStore, CastsBusinessLogic {
    var casts: [Cast]?
    var movieId: Int?
    
    var castsWorker = CastWorker(castStore: CastApiStore())
    var presenter: CastsPresentationLogic?
    
    func fetchCasts(request: CastsModel.FetchCasts.Request) {
    }
}


