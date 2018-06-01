//
//  MenuBarButtonItem.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 31/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import DropDown

enum MenuItem: String {
    case FavouriteMovies = "Favourite Movies"
}

class MainMenuBarButtonItem: UIBarButtonItem {
    private var dropDown: DropDown?
    weak var viewController: UIViewController!
    
    func initialize(withViewController viewController: UIViewController, items: [MenuItem]) {
        self.viewController = viewController
        
        dropDown = DropDown()
        dropDown?.anchorView = self
        dropDown?.dataSource = items.map { $0.rawValue }
        
        target = self
        action = #selector(show(_:))
        
        dropDown?.selectionAction = { [weak self] (index, item) in
            self?.route(index: index, item: item)
        }
    }

    @objc func show(_ sender: UIBarButtonItem) {
        dropDown?.show()
    }
    
    private func route(index: Int, item: String) {
        switch item {
        case MenuItem.FavouriteMovies.rawValue:
            routeToFavouriteMovies()
        default:
            print("No route found for \(item)")
        }
    }
    
    private func routeToFavouriteMovies() {
        let destVc = viewController.storyboard?.instantiateViewController(withIdentifier: "FavouriteMovieViewController") as! FavouriteMovieViewController
        
        viewController.show(destVc, sender: nil)
    }
}
