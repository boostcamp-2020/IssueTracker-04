//
//  CommentCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

protocol CommentCellData {
    var comment: String { get }
    var authorName: String { get }
    var authorImg: String { get }
    var commentDate: Date { get }
}

class CommentCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentLabelHeightConstraint: NSLayoutConstraint!
    
    var cellWidth: CGFloat? {
        didSet {
            guard let cellWidth = cellWidth else {
                return
            }
            containerViewWidthConstraint.constant = cellWidth
            
            let sizeToFitIn = CGSize(width: cellWidth - 32, height: CGFloat(MAXFLOAT))
            let commentLabeSize = commentLabel.sizeThatFits(sizeToFitIn)
            commentLabelHeightConstraint.constant = commentLabeSize.height
        }
    }
    
    func configure(with data: CommentCellData) {
        authorImageView.image = UIImage.checkmark //http 통신으로 로드
        authorLabel.text = data.authorName
        dateLabel.text = Date().difference(with: data.commentDate)
        commentLabel.text = data.comment
        authorImageView.clipsToBounds = true
        authorImageView.layer.cornerRadius = authorImageView.frame.width/2
    }
}
