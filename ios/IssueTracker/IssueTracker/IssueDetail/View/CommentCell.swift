//
//  CommentCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

protocol CommentCellData {
    var comment: String { get }
    var authorNo: Int { get }
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
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
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
    
    func configure() {
        authorImageView.image = UIImage.checkmark //http 통신으로 로드
        authorLabel.text = "JK"
        dateLabel.text = "27 minutes ago"
        commentLabel.text = "안녕하세요 JK입니다 \n 하하하 하하하하\n 감사합니다. \n 하하핳하하하핳하하하핳하ㅏ하하하하핳하하하핳하하하핳하ㅏ하하하하핳하하하핳하하하핳하ㅏ하하하하핳하하하핳하하하핳하ㅏ하하하하핳하하하핳하하하핳하ㅏ하하하하핳하하하핳하하하핳하ㅏ하하하하핳하하하핳하하하핳하ㅏ하하"
//        authorLabel.text = String(data.authorNo)
//        dateLabel.text = data.commentDate.string
//        commentLabel.text = data.comment
    }
}
