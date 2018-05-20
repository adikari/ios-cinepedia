//
//  MovieDetailViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

protocol MovieDetailDisplayLogic {
    func displayMovie(viewModel: MovieDetailModel.FetchMovieDetail.ViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic {
   
    @IBOutlet weak var movieDetailView: MovieDetailView!
    
    var presenter: MovieDetailPresentationLogic?
    var router: (NSObjectProtocol & MovieDetailRouterLogic & MovieDetailDataPassing)?
    var interactor: MovieDetailBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovie()
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
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
        
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    private func fetchMovie() {
        if let movieId = router?.dataStore?.movieId {
            let request = MovieDetailModel.FetchMovieDetail.Request(movieId: movieId)
            
            interactor?.fetchMovieDetail(request: request)
        }
    }
    
    // MARK: Display logic
    
    func displayMovie(viewModel: MovieDetailModel.FetchMovieDetail.ViewModel) {
        movieDetailView.initialize(movie: viewModel.movie)
    }
}
