//
//  LatestMoviesViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 7/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

protocol LatestMoviesViewDisplayLogic: class {
    func displayLatestMovies(viewModel: LatestMovies.ViewModel)
}

class LatestMoviesViewController: UIViewController, LatestMoviesViewDisplayLogic {
    
    var interactor: LatestMoviesBusinessLogic?
    var movies: [LatestMovies.ViewModel.Movie] = []
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLatestMovies()
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
        let interactor = LatestMoviesInteractor()
        let presenter = LatestMoviesPresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    private func fetchLatestMovies() {
        let request = LatestMovies.Request(numberOfMovies: 15)
        interactor?.fetchLatestMovies(request: request)
    }
    
    // MARK: Display Logic
    
    func displayLatestMovies(viewModel: LatestMovies.ViewModel) {
        
    }
}
