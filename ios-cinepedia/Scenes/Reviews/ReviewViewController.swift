//
//  ReviewViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

protocol ReviewDisplayLogic {
    func displayReview(viewModel: ReviewModel.FetchReview.ViewModel)
}

class ReviewViewController: UIViewController, ReviewDisplayLogic {
    
    var presenter: ReviewPresentationLogic?
    var router: (NSObjectProtocol & ReviewRouterLogic & ReviewDataPassing)?
    var interactor: ReviewBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchReview()
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
        let interactor = ReviewInteractor()
        let presenter = ReviewPresenter()
        let router = ReviewRouter()
        
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    private func fetchReview() {
        if let movieId = router?.dataStore?.movieId {
            let request = ReviewModel.FetchReview.Request(movieId: movieId)
            interactor?.fetchReview(request: request)
        }
    }
    
    func displayReview(viewModel: ReviewModel.FetchReview.ViewModel) {
        
    }
}
