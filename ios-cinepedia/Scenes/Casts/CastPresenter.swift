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
        var fetchedCasts: [CastsModel.FetchCasts.ViewModel.Cast] = []
        
        let casts = Array(response.casts.prefix(15))
        
        for cast in casts {
            let castModel = CastsModel.FetchCasts.ViewModel.Cast(
                name: cast.name,
                character: cast.character,
                imageUrl: cast.profileImage(width: 138, height: 175) ?? ""
            )

            fetchedCasts.append(castModel)
        }
        
        let viewModel = CastsModel.FetchCasts.ViewModel(casts: fetchedCasts)
        viewController?.displayCasts(viewModel: viewModel)
    }
}
