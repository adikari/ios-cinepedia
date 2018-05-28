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
        if ((author.text?.isEmpty)! || (content.text?.isEmpty)!) {
            return ValidationResult.success
        }
        
        return ValidationResult.failure
    }
}

enum ValidationResult {
    case success
    case failure
}
