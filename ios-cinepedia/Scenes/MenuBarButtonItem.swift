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
    let dropDown = DropDown()
    
    override func awakeFromNib() {
        dropDown.anchorView = self // UIView or UIBarButtonItem
        
        dropDown.dataSource = ["Favourite Movies"]
        
        target = self
        action = #selector(show(_:))
    }

    @objc func show(_ sender: UIBarButtonItem) {
        dropDown.show()
    }
}
