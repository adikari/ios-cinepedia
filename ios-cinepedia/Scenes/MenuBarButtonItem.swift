//
//  MenuBarButtonItem.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 31/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit
import DropDown

class MainMenuBarButtonItem: UIBarButtonItem {
    var dropDown: DropDown?
    weak var viewController: UIViewController!
    
    func initialize(withViewController viewController: UIViewController) {
        self.viewController = viewController
        dropDown = DropDown()
        dropDown?.anchorView = self
        
        dropDown?.dataSource = ["Favourite Movies"]
        
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
        let destVc = viewController.storyboard?.instantiateViewController(withIdentifier: "FavouriteMovieViewController") as! FavouriteMovieViewController

        viewController.show(destVc, sender: nil)
    }
}
