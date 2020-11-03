//
//  IssueDetailCollectionViewHeader.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

class IssueDetailCollectionViewHeader: UICollectionReusableView {

    static var identifier: String {
        String(describing: Self.self)
    }
    
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
}
