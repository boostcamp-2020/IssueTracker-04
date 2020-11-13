//
//  IssueDetailSlideViewHeader.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/03.
//

import UIKit

class IssueDetailSlideViewHeader: UICollectionReusableView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var editButton: UIButton!
  
    var buttonHandler: (() -> Void)?
    
    @IBAction func editButtonTouched(_ sender: Any) {
        buttonHandler?()
    }
}
