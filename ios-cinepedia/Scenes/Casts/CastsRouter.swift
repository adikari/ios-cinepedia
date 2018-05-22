//
//  CastsRouter.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import Foundation

protocol CastsRouterLogic { }

protocol CastsDataPassing {
    var dataStore: CastsDataStore? { get }
}

class CastsRouter: NSObject, CastsRouterLogic, CastsDataPassing {
    var viewController: CastsViewController?
    var dataStore: CastsDataStore?
}
