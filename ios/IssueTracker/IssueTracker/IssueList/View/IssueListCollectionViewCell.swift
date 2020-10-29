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
    @IBOutlet var labelContainerView: LabelContainerView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    var cellWidth: CGFloat? {
        didSet {
            guard let width = cellWidth else {
                return
            }
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerViewWidthConstraint.constant = width
            labelContainerView.maxWidth = width - 16
        }
    }
    
    var labelRowCount: CGFloat? {
        didSet {
            guard let count = labelRowCount else {
                return
            }
            labelContainerView.translatesAutoresizingMaskIntoConstraints = false
            labelContainerViewHeightConstraint.constant = 20 * count
        }
    }
    
    func configure(with data: IssueListCollectionViewCellData) {
        titleLabel.text = data.issueTitle
        contentLabel.text = data.issueContent
        milestoneLabel.text = data.milestoneTitle
        labelContainerView.add(labels: data.labels)
        labelRowCount = CGFloat(labelContainerView.labelRows)
    }
    
    override func prepareForReuse() {
        labelContainerView.clear()
    }
}
