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
    
    @IBOutlet weak var rightContainerView: UIView!
    @IBOutlet weak var leftContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewWidthConstraint: NSLayoutConstraint!
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    var cellMainWidth: CGFloat? {
        didSet {
            guard let width = cellMainWidth else {
                return
            }
            containerView.translatesAutoresizingMaskIntoConstraints = false
            mainViewWidthConstraint.constant = width
            containerViewWidthConstraint.constant = width * 1.5
            labelContainerView.maxWidth = width - 16
            showMainView()
        }
    }
    
    private var leftContainerViewWidth: CGFloat {
        (cellMainWidth ?? 0 ) * 0.15
    }
    
    private var rigthContainerViewWidth: CGFloat {
        (cellMainWidth ?? 0 ) * 0.35
    }
    
    private var leftShowOrigin: CGPoint = .zero
    private var mainShowOrigin: CGPoint {
        CGPoint(x: leftContainerViewWidth, y: 0)
    }
    private var rightShowOrigin: CGPoint {
        CGPoint(x: leftContainerViewWidth + rigthContainerViewWidth, y: 0)
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
    
    func showLeftContainerView() {
        bounds.origin = leftShowOrigin
    }
    
    func showMainView() {
        bounds.origin = mainShowOrigin
    }
    
    func showRightContainerView() {
        bounds.origin = rightShowOrigin
    }
    
    func leftContainerViewShowAnimate() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.showLeftContainerView()
        }
    }
    
    func rightContainerViewShowAnimate() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.showRightContainerView()
        }
    }
    
    func resetViewAnimate() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.showMainView()
        }
    }
    
    override func prepareForReuse() {
        labelContainerView.clear()
    }
}
