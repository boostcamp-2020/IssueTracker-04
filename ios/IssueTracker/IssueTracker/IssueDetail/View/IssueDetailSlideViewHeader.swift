//
//  IssueDetailSlideViewHeader.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/03.
//

import UIKit

class IssueDetailSlideViewHeader: UICollectionViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerButton: UIButton!
    
    @IBAction func headerButtonTouched(_ sender: UIButton) {
        
    }
    
    func setHeader(title: String) {
        headerLabel.text = title
    }
    
}
