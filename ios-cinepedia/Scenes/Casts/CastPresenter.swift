//
//  CastPresenter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol CastsPresentationLogic {
    func displayCasts(response: CastsModel.FetchCasts.Response)
}

class CastsPresenter: CastsPresentationLogic {
    var viewController: CastsViewController?
    
    func displayCasts(response: CastsModel.FetchCasts.Response) {
        
    }
}
