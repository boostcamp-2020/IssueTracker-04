//
//  ClosedCollectionViewCell.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/09.
//

import UIKit

class ClosedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var closeButton: UIButton!
    var touchHandler: (() -> Void)?
    
    func setCloseButtonLabel(flag: Bool) {
        let string = flag ? "Close Issue" : "Reopen Issue"
        let color: UIColor = flag ? .systemRed : .systemGreen
        let image: UIImage? =  flag ? UIImage(systemName: "exclamationmark.triangle") : UIImage(systemName: "exclamationmark.arrow.circlepath")
        
        UIView.setAnimationsEnabled(false)
        closeButton.setTitle(string, for: .normal)
        closeButton.setTitleColor(color, for: .normal)
        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = color
        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
       
    }
    
    @IBAction func closeButtonTouched(_ sender: UIButton) {
        touchHandler?()
    }
}
