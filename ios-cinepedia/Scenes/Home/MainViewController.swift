//
//  MainViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

protocol MainViewDisplayLogic: class
{
    func displayFeaturedMovie(viewModel: ListMovies.Featured.ViewModel)
}

class MainViewController: UIViewController, MainViewDisplayLogic, FSPagerViewDelegate, FSPagerViewDataSource {
    
    var interactor: ListMoviesBusinessLogic?
    var featuredMovies: [ListMovies.Featured.ViewModel.FeaturedMovie] = []
    
    @IBOutlet weak var featuredMovieView: FSPagerView! {
        didSet {
            featuredMovieView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "featuredMovieCell")
        }
    }
    
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
        
        featuredMovieView.dataSource = self
        featuredMovieView.delegate = self
        fetchFeaturedMovie()
    }
    
    func fetchFeaturedMovie() {
        interactor?.fetchFeaturedMovie(request: ListMovies.Featured.Request())
    }

    // MARK: Display logic
    
    func displayFeaturedMovie(viewModel: ListMovies.Featured.ViewModel) {
        featuredMovies = viewModel.featuredMovies
        featuredMovieView.reloadData()
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return featuredMovies.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let movie = featuredMovies[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "featuredMovieCell", at: index)
        
        cell.imageView?.kf.setImage(with: URL(string: movie.imageUrl))
        cell.textLabel?.text = movie.title
        
        return cell
    }
}
