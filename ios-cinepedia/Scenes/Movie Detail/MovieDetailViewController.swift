//
//  MovieDetailViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 14/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Toaster

protocol MovieDetailDisplayLogic {
    func displayMovie(viewModel: MovieDetailModel.FetchMovieDetail.ViewModel)
    func displayFavourite(viewModel: MovieDetailModel.FetchFavourite.ViewModel)
    func setFavourite(viewModel: MovieDetailModel.SetFavourite.ViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic, NVActivityIndicatorViewable {
   
    @IBOutlet weak var movieDetailView: MovieDetailView!
    @IBOutlet weak var mainMenu: MainMenuBarButtonItem!

    var presenter: MovieDetailPresentationLogic?
    var router: (NSObjectProtocol & MovieDetailRouterLogic & MovieDetailDataPassing)?
    var interactor: MovieDetailBusinessLogic?

    private var isFavourite: Bool?
    private var movie: MovieDetailModel.FetchMovieDetail.ViewModel.Movie?
    private var indicator: NVActivityIndicatorView?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenu.initialize(withViewController: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMovie()
        fetchFavourite()
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
    
    // MARK: Actions
    
    @IBAction func displayReviews(_ sender: Any) {
        performSegue(withIdentifier: "Reviews", sender: sender)
    }
    
    @IBAction func displayCasts(_ sender: Any) {
        performSegue(withIdentifier: "Casts", sender: sender)
    }
   
    @IBAction func setFavourite(_ sender: UIBarButtonItem) {
        if let movieId = movie?.id, let isFavourite = isFavourite {
            let request = MovieDetailModel.SetFavourite.Request(movieId: movieId, isFavourite: !isFavourite)
            interactor?.setFavourite(request: request)
        }
    }
    
    // Fetch Movie
    
    private func fetchMovie() {
        if let movieId = router?.dataStore?.movieId {
            let request = MovieDetailModel.FetchMovieDetail.Request(movieId: movieId)
            
            startAnimating(type: .ballScaleMultiple)
            interactor?.fetchMovieDetail(request: request)
        }
    }
    
    // Fetch Favourite
    
    private func fetchFavourite() {
        if let movieId = router?.dataStore?.movieId {
            let request = MovieDetailModel.FetchFavourite.Request(movieId: movieId)
            interactor?.isFavourite(request: request)
        }
    }
    
    // MARK: Router
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Display logic
    
    func displayMovie(viewModel: MovieDetailModel.FetchMovieDetail.ViewModel) {
        stopAnimating()
        
        movie = viewModel.movie
        movieDetailView.initialize(movie: viewModel.movie)
    }
    
    func displayFavourite(viewModel: MovieDetailModel.FetchFavourite.ViewModel) {
        isFavourite = viewModel.isFavourite
        movieDetailView.displayFavouriteIcon(isFavourite: viewModel.isFavourite)
    }
    
    func setFavourite(viewModel: MovieDetailModel.SetFavourite.ViewModel) {
        isFavourite = viewModel.isFavourite
        movieDetailView.displayFavouriteIcon(isFavourite: viewModel.isFavourite)
        let message = viewModel.isFavourite ? "Movie added to favourites" : "Movie removed from favourites"

        Toast(text: message).show()
    }
}
