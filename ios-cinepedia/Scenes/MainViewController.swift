//
//  MainViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var popularMoviesViewController: PopularMoviesViewController = {
        var viewController = storyboard().instantiateViewController(withIdentifier: "PopularMoviesViewController") as! PopularMoviesViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var latestMoviesViewController: LatestMoviesViewController = {
        var viewController = storyboard().instantiateViewController(withIdentifier: "LatestMoviesViewController") as! LatestMoviesViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    private func storyboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
  
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

