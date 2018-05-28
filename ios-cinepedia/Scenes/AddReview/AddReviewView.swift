//
//  AddReviewView.swift
//  ios-cinepedia
//
//  Created by subash adhikari on 28/5/18.
//  Copyright © 2018 subash adhikari. All rights reserved.
//

import UIKit

class AddReviewView: UIView {
    @IBOutlet var author: UITextField!
    @IBOutlet var content: UITextView!
    
    func validate() -> ValidationResult {
        var errors = [String]()
        
        if let authorField = author.text, authorField.isEmpty {
            errors.append("Author must be entered.")
            author.layer.borderWidth = 1.0
            author.layer.borderColor = UIColor.red.cgColor
        } else {
            author.layer.borderWidth = 0
            author.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        if let reviewField = content.text, reviewField.isEmpty {
            content.layer.borderWidth = 1.0
            content.layer.borderColor = UIColor.red.cgColor
            errors.append("Review must be entered.")
        } else {
            author.layer.borderWidth = 0
            content.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        if (errors.count > 0) {
            return ValidationResult.failure(errors: errors)
        }
        
        return ValidationResult.success
    }
}

enum ValidationResult {
    case success
    case failure(errors: [String])
}
