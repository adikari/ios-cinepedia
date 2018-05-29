//
//  PopularMoviesViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

protocol PopularMoviesViewDisplayLogic: class {
    func displayPopularMovies(viewModel: PopularMovies.ViewModel)
}

class PopularMoviesViewController: UIViewController, PopularMoviesViewDisplayLogic, FSPagerViewDataSource, FSPagerViewDelegate  {

    var interactor: PopularMoviesBusinessLogic?
    var movies: [PopularMovies.ViewModel.Movie] = []

    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            pagerView.automaticSlidingInterval = 10.0
            pagerView.isInfinite = true
        }
    }

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.dataSource = self
        pagerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPopularMovies()
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
        let interactor = PopularMoviesInteractor()
        let presenter = PopularMoviesPresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    func fetchPopularMovies() {
        interactor?.fetchFeaturedMovie(request: PopularMovies.Request())
    }
    
    // MARK: Display logic
    
    func displayPopularMovies(viewModel: PopularMovies.ViewModel) {
        movies = viewModel.movies
        pagerView.reloadData()
    }
}

extension PopularMoviesViewController {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return movies.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let movie = movies[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: URL(string: movie.imageUrl))
        cell.textLabel?.text = movie.title
        
        return cell
    }
}
