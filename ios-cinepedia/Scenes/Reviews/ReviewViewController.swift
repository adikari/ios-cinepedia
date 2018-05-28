//
//  ReviewViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 22/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol ReviewDisplayLogic {
    func displayReview(viewModel: ReviewModel.FetchReview.ViewModel)
}

class ReviewViewController: UIViewController, ReviewDisplayLogic, NVActivityIndicatorViewable {
   var router: (NSObjectProtocol & ReviewRouterLogic & ReviewDataPassing)?
    
    private var presenter: ReviewPresentationLogic?
    private var interactor: ReviewBusinessLogic?
    private var reviews: [ReviewModel.FetchReview.ViewModel.Review] = []
    
    @IBOutlet weak var reviewListTableView: UITableView!

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewListTableView.delegate = self
        reviewListTableView.dataSource = self
        reviewListTableView.tableFooterView = UIView()

        reviewListTableView.estimatedRowHeight = 140
        reviewListTableView.rowHeight = UITableViewAutomaticDimension

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
    
    // MARK: Fetch reviews
    
    private func fetchReview() {
        if let movieId = router?.dataStore?.movieId {
            startAnimating(type: .ballScaleMultiple)
            let request = ReviewModel.FetchReview.Request(movieId: movieId)
            interactor?.fetchReview(request: request)
        }
    }
    
    func displayReview(viewModel: ReviewModel.FetchReview.ViewModel) {
        stopAnimating()
        
        reviews = viewModel.reviews
        
        if reviews.count > 0 {
            reviewListTableView.reloadData()
        } else {
            reviewListTableView.emptyMessage(message: "No reviews found.")
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
    
    // MARK: Actions
    
    @IBAction func addReview(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddReview", sender: sender)
    }
}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell {
            cell.initialize(review: reviews[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell(style: .value1, reuseIdentifier: "ReviewTableViewCell")
    }
}


