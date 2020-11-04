//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/03.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var badgeLabel: BadgeLabel!
    
    func setLabel(data label: Label) {
        badgeLabel.text = label.labelTitle
        badgeLabel.backgroundColor = UIColor(hexString: label.labelColor)
    }
    
}
