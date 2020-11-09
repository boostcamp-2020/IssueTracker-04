//
//  ClosedCollectionViewCell.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/09.
//

import UIKit

class ClosedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var closedButton: UIButton!
    var closedHandler: (() -> Void)?
    
    func setClosedButtonLabel(flag: Bool) {
        let string = flag ? "Reopen issue" : "Close issue"
        closedButton.setTitle(string, for: .normal)
    }
    
    @IBAction func closedButtonTouched(_ sender: UIButton) {
        closedHandler?()
    }
}
