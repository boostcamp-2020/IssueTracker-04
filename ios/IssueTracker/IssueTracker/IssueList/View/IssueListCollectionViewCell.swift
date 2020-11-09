//
//  IssueListCollectionViewCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

protocol IssueListCollectionViewCellData {
    var issueNo: Int { get }
    var issueTitle: String { get }
    var issueContent: String { get }
    var milestoneTitle: String { get }
    var labels: [Label] { get }
}

class IssueListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var milestoneLabel: BadgeLabel!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var labelContainerView: LabelContainerView!
    @IBOutlet weak var rightContainerView: UIView!
    @IBOutlet weak var leftContainerView: UIView!
    
    @IBOutlet weak var mainViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewWidthConstraint: NSLayoutConstraint!
    
    var issueNo: Int?
    var mode: IssueListViewController.Mode = .normal
    
    var cellMainWidth: CGFloat? {
        didSet {
            guard let width = cellMainWidth else {
                return
            }
            mainViewWidthConstraint.constant = width
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
    
    override var isSelected: Bool {
        didSet {
           setSelectionButton(isSelected: isSelected)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSwipeGesture()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSwipeGesture()
    }
    
    func configure(with data: IssueListCollectionViewCellData) {
        titleLabel.text = data.issueTitle
        contentLabel.text = data.issueContent
        milestoneLabel.text = data.milestoneTitle
        labelContainerView.add(labels: data.labels)
        labelRowCount = CGFloat(labelContainerView.labelRows)
        setSelectionButton(isSelected: isSelected)
        issueNo = data.issueNo
    }
    
    private func addSwipeGesture() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeLeft(_:)))
        leftSwipe.direction = .left
        self.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeRight(_:)))
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
    }
    
    @objc private func onSwipeLeft(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard mode == .normal else { return }
        rightContainerViewShowAnimate()
    }
    
    @objc private func onSwipeRight(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard mode == .normal else { return }
        resetViewAnimate()
    }
    
    func animateAfterConstraintChanged() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func showMainView() {
        mainViewLeadingConstraint.constant = 0
        mainViewTrailingConstraint.constant = 0
    }
    
    func resetViewAnimate() {
        showMainView()
        animateAfterConstraintChanged()
    }
    
    func setSelectionButton(isSelected: Bool) {
        isSelected ? selectionButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal) : selectionButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
    }
    
    override func prepareForReuse() {
        labelContainerView.clear()
    }
    
    @IBAction func closeButtonTouched(_ sender: UIButton) {
        guard let issueNo = issueNo else {
            return
        }
        NotificationCenter.default.post(name: .issueCloseRequested, object: nil, userInfo: ["IssueNo": issueNo])
    }
    
    @IBAction func deleteButtonTouched(_ sender: UIButton) {
        guard let issueNo = issueNo else {
            return
        }
        NotificationCenter.default.post(name: .issueDeleteRequested, object: nil, userInfo: ["IssueNo": issueNo])
    }
}

extension IssueListCollectionViewCell: LeftContainerContaining {
    
    private var leftContainerViewWidth: CGFloat {
        leftContainerView.frame.width
    }
    
    func showLeftContainerView() {
        mainViewLeadingConstraint.constant = leftContainerViewWidth
        mainViewTrailingConstraint.constant = -leftContainerViewWidth
    }
    
    func leftContainerViewShowAnimate() {
        showLeftContainerView()
        animateAfterConstraintChanged()
    }
}

extension IssueListCollectionViewCell: RightContainerContaining {
    
    private var rightContainerViewWidth: CGFloat {
        rightContainerView.frame.width
    }
    
    private var rightShowOrigin: CGPoint {
        CGPoint(x: leftContainerViewWidth + rightContainerViewWidth, y: 0)
    }
    
    func showRightContainerView() {
        mainViewLeadingConstraint.constant = -rightContainerViewWidth
        mainViewTrailingConstraint.constant = rightContainerViewWidth
    }
    
    func rightContainerViewShowAnimate() {
        showRightContainerView()
        animateAfterConstraintChanged()
    }
}
