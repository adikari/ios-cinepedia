//
//  CastsViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol CastsDisplayLogic {
    func displayCasts(viewModel: CastsModel.FetchCasts.ViewModel)
}

class CastsViewController: UIViewController, CastsDisplayLogic, NVActivityIndicatorViewable {
    
    var presenter: CastsPresentationLogic?
    var router: (NSObjectProtocol & CastsRouterLogic & CastsDataPassing)?
    var interactor: CastsBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCasts()
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let interactor = CastsInteractor()
        let presenter = CastsPresenter()
        let router = CastsRouter()
        
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    func displayCasts(viewModel: CastsModel.FetchCasts.ViewModel) {
        stopAnimating()
    }
    
    private func fetchCasts() {
        if let movieId = router?.dataStore?.movieId {
            startAnimating(type: .ballScaleMultiple)
            let request = CastsModel.FetchCasts.Request(movieId: movieId)
            interactor?.fetchCasts(request: request)
        }
    }
}
