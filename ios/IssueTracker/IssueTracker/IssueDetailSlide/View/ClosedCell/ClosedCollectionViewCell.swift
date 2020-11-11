//
//  ClosedCollectionViewCell.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/09.
//

import UIKit

class ClosedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var closedButton: UIButton!
    var touchHandler: (() -> Void)?
    
    func setClosedButtonLabel(flag: Bool) {
        let string = flag ? "Reopen Issue" : "Close Issue"
        let color = flag ? UIColor.systemGreen : UIColor.systemRed
        
        closedButton.setTitle(string, for: .normal)
        closedButton.setTitleColor(color, for: .normal)
    }
    
    @IBAction func closedButtonTouched(_ sender: UIButton) {
        touchHandler?()
    }
}
