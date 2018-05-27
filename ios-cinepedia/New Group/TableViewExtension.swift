//
//  TableViewExtension.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 27/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

extension UITableView {
    
    func emptyMessage(message: String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: bounds.size.width, height: bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        backgroundView = messageLabel;
        separatorStyle = .none;
    }
}
