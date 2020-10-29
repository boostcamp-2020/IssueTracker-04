//
//  IssueListCollectionViewCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

protocol IssueListCollectionViewCellData {
    var issueTitle: String { get }
    var issueContent: String { get }
    var milestoneTitle: String { get }
    var labels: [Label] { get }
}

class IssueListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var milestoneLabel: BadgeLabel!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!    
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    var cellWidth: CGFloat? {
        didSet {
            guard let width = cellWidth else {
                return
            }
            containerViewWidthConstraint.constant = width
        }
    }
    
    func configure(with data: IssueListCollectionViewCellData) {
        titleLabel.text = data.issueTitle
        contentLabel.text = data.issueContent
        milestoneLabel.text = data.milestoneTitle
    }
}