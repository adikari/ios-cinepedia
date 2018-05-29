//
//  LatestMoviesViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 7/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import FSPagerView

protocol LatestMoviesViewDisplayLogic: class {
    func displayLatestMovies(viewModel: LatestMovies.ViewModel)
    func displayMovieDetail(movie: LatestMovies.ViewModel.Movie)
}

class LatestMoviesViewController: UIViewController, LatestMoviesViewDisplayLogic, FSPagerViewDataSource, FSPagerViewDelegate {

    var interactor: LatestMoviesBusinessLogic?
    var movies: [LatestMovies.ViewModel.Movie] = []
    var router: (NSObjectProtocol & LatestMoviesDataPassing & LatestMoviesRouterLogic)?
    

    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
             pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            pagerView.transformer = FSPagerViewTransformer(type: .linear)
            pagerView.itemSize = CGSize(width: 300, height: 180)
        }
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.delegate = self
        pagerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        let router = LatestMoviesRouter()
        
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    private func fetchLatestMovies() {
        interactor?.fetchLatestMovies(request: LatestMovies.Request())
    }

    // MARK: Display Logic
    
    func displayLatestMovies(viewModel: LatestMovies.ViewModel) {
        movies = viewModel.movies
        pagerView.reloadData()
    }
    
    func displayMovieDetail(movie: LatestMovies.ViewModel.Movie) {
        router?.routeToMovieDetail(movie: movie)
    }
}

extension LatestMoviesViewController {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return movies.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let movie = movies[index]
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: URL(string: movie.imageUrl))
        cell.textLabel?.text = movie.title

        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        displayMovieDetail(movie: movies[index])
    }
}
