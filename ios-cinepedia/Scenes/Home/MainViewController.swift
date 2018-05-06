//
//  MainViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

protocol MainViewDisplayLogic: class
{
    func displayFeaturedMovie(viewModel: ListMovies.Featured.ViewModel)
}

class MainViewController: UIViewController, MainViewDisplayLogic {
    
    var interactor: ListMoviesBusinessLogic?

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let interactor = ListMoviesInteractor()
        let presenter = ListMoviesPresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchFeaturedMovie()
    }
    
    func fetchFeaturedMovie() {
        interactor?.fetchFeaturedMovie(request: ListMovies.Featured.Request())
    }


    // MARK: Display logic
    
    func displayFeaturedMovie(viewModel: ListMovies.Featured.ViewModel) {
        
    }
}
