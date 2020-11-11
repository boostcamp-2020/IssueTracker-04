//
//  BadgeTableViewCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {

    @IBOutlet weak var badgeLabel: BadgeLabel!
    
    func configure(with title: String, color: String) {
        badgeLabel.text = title
        let uiColor = UIColor(hexString: color)
        badgeLabel.backgroundColor = uiColor
        badgeLabel.borderColor = uiColor
        badgeLabel.textColor = uiColor.visibleTextColor
        badgeLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
    func configure(with milestoneTitle: String) {
        badgeLabel.text = milestoneTitle
        badgeLabel.backgroundColor = .clear
        badgeLabel.borderColor = .systemGray2
        badgeLabel.textColor = .systemGray2
        badgeLabel.font = UIFont.systemFont(ofSize: 15)
    }
}
