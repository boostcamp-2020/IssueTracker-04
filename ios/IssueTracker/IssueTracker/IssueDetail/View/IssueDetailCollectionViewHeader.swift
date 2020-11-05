//
//  IssueDetailCollectionViewHeader.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

protocol DetailHeaderData {
    var issueNo: Int { get }
    var issueTitle: String { get }
    var issueContent: String { get }
    var issueFlag: Bool { get }
    var issueDate: Date { get }
    var issueAuthorID: String { get }
}

class IssueDetailCollectionViewHeader: UICollectionReusableView {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var issueTitleLableHeightConstraint: NSLayoutConstraint!
    
    var viewWidth: CGFloat? {
        didSet {
            guard let viewWidth = viewWidth else {
                return
            }
            
            containerViewWidthConstraint.constant = viewWidth
            let sizeToFitIn = CGSize(width: viewWidth - 32, height: CGFloat(MAXFLOAT))
            let issueTitleLabelSize = issueTitleLabel.sizeThatFits(sizeToFitIn)
            issueTitleLableHeightConstraint.constant = issueTitleLabelSize.height
        }
    }
    
    func configure(with data: DetailHeaderData) {
        authorImageView.image = UIImage.checkmark
        authorNameLabel.text = data.issueAuthorID
        issueTitleLabel.text = data.issueTitle
        issueNumberLabel.text = "#\(data.issueNo)"
    }
}
