//
//  BadgeTableViewCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {
    
    var badgeLabel: BadgeLabel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        attachBadgeLabel()
    }
    
    private func attachBadgeLabel() {
        let badge = BadgeLabel()
        contentView.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        badge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        badgeLabel = badge
    }
    
    func configure(with title: String, color: String) {
        badgeLabel?.text = title
        let uiColor = UIColor(hexString: color)
        badgeLabel?.backgroundColor = uiColor
        badgeLabel?.borderColor = uiColor
        badgeLabel?.textColor = uiColor.visibleTextColor
        badgeLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    func configure(with milestoneTitle: String) {
        badgeLabel?.text = milestoneTitle
        badgeLabel?.backgroundColor = .clear
        badgeLabel?.borderColor = .systemGray2
        badgeLabel?.textColor = .systemGray2
        badgeLabel?.font = UIFont.systemFont(ofSize: 15)
    }
}
