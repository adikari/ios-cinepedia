//
//  AddReviewViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import Toaster

class AddReviewViewController: UIViewController {
    
    var router: (NSObjectProtocol & AddReviewRouterLogic & AddReviewDataPassing)?
    
    private var presenter: AddReviewPresentationLogic?
    private var interactor: AddReviewBusinessLogic?
    
    @IBOutlet var addReviewView: AddReviewView!

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
        let interactor = AddReviewInteractor()
        let presenter = AddReviewPresenter()
        let router = AddReviewRouter()
        
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Add review
    
    @IBAction func addReview(_ sender: UIButton!) {
        if let movieId = router?.dataStore?.movieId {
            switch(addReviewView.validate()) {
            case .success:
                addReview(forMovie: movieId)
            case .failure(let errors):
                Toast(text: errors.joined(separator: "\n")).show()
            }
        }
    }
    
    func addReview(forMovie movieId: Int) {
        let reviewToCreate = AddReviewModel.AddReview.ViewModel.Review(
            author: addReviewView.author.text!,
            content: addReviewView.content.text!
        )
        
        let request = AddReviewModel.AddReview.Request(review: reviewToCreate, movieId: movieId)
        
        interactor?.addReview(request: request)
    }
    
    func displayMessage(success: Bool) {
        if (success) {
            router?.routeToReviews(segue: nil)
            Toast(text: "Review Saved.").show()
        } else {
            Toast(text: "Error saving review!!").show()
        }
    }
}
