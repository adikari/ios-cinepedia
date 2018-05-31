//
//  MainViewController.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 6/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainMenu: MainMenuBarButtonItem!
    
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
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

