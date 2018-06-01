//
//  FavouriteMovieViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 31/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol FavouriteMoviesDisplayLogic {
    func displayFavouriteMovies(viewModel: FavouriteMovieModel.FetchFavouriteMovies.ViewModel)
}

class FavouriteMovieViewController : UIViewController, FavouriteMoviesDisplayLogic, NVActivityIndicatorViewable {
    
    private var presenter: FavouriteMoviePresentationLogic?
    private var interactor: FavouriteMovieBusinessLogic?
    private var favourites = [FavouriteMovieModel.FetchFavouriteMovies.ViewModel.Movie]()
    
    var router: (NSObjectProtocol & FavouriteMovieRouterLogic & FavouriteMovieDataPassing)?
    
    @IBOutlet weak var favouritesTableView: UITableView!

    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouritesTableView.dataSource = self
        favouritesTableView.delegate = self
        
        favouritesTableView.tableFooterView = UIView()
        favouritesTableView.rowHeight = UITableViewAutomaticDimension
        favouritesTableView.estimatedRowHeight = 175
        
        fetchFavourites()
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
        let interactor = FavouriteMovieInteractor()
        let presenter = FavouriteMoviePresenter()
        let router = FavouriteMovieRouter()
        
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    // MARK: Fetch favourite movies
    
    func fetchFavourites() {
        startAnimating(type: .ballScaleMultiple)
        let request = FavouriteMovieModel.FetchFavouriteMovies.Request()
        interactor?.fetchFavouriteMovies(request: request)
    }
    
    // MARK: Display logick
    
    func displayFavouriteMovies(viewModel: FavouriteMovieModel.FetchFavouriteMovies.ViewModel) {
        stopAnimating()
        favourites = viewModel.movies
        
        if favourites.count > 0 {
            favouritesTableView.reloadData()
        } else {
            favouritesTableView.emptyMessage(message: "You haven't favourited any movies :(")
        }
    }
}

extension FavouriteMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell") as? FavouriteTableViewCell {
            cell.initialize(movie: favourites[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell(style: .value1, reuseIdentifier: "FavouriteTableViewCell")
    }
}
