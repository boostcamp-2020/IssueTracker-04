//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

class IssueDetailViewController: UIViewController {
    
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var detailCollectionView: IssueDetailCollectionView!
    
    @IBOutlet weak var slideViewTobConstraint: NSLayoutConstraint!
    
    var slideViewPanGesture = UIPanGestureRecognizer()
    var issueTitle: String = "IssueTitle"
    var detailCollectionViewAdapter: IssueDetailCollectionViewAdapter!
    
    var minimumSlideViewVisibleHeight: CGFloat = 92
    var maximumSlideViewVisibleHeight: CGFloat {
        slideView.frame.height - 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestureRecognizer()
        configureCollectionView()
        configureSlideView()
    }
    
    private func configureGestureRecognizer() {
        slideViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(slideViewPanned))
        slideViewPanGesture.cancelsTouchesInView = false
        slideView.addGestureRecognizer(slideViewPanGesture)
    }
    
    private func configureSlideView() {
        guard let slideViewController = children.first as? IssueDetailSlideViewController,
              let detailItem = detailCollectionViewAdapter.dataManager.detailItem,
              let issueInfo = detailCollectionViewAdapter.dataManager.issueInfo else {
            return
        }
        let slideViewDataManager = IssueSlideViewDataSourceManager()
        slideViewController.delegate = self
        slideViewDataManager.assignees = detailItem.assignees
        slideViewDataManager.labels = detailItem.labels
        slideViewDataManager.milestone = detailItem.milestone
        slideViewDataManager.issueFlag = issueInfo.isOpen
        
        slideViewController.adapter = IssueSlideVIewCollectionViewAdapter(dataManager: slideViewDataManager)
        slideViewController.reloadData()
        slideViewPanGesture.delegate = slideViewController
    }
    
    private func configureCollectionView() {
        let dataManager = IssueDetailDataSourceManager()
        detailCollectionViewAdapter = IssueDetailCollectionViewAdapter(dataManager: dataManager)
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = detailCollectionViewAdapter
        detailCollectionView.setHeaderSize(with: issueTitle, width: detailCollectionView.frame.width)
        detailCollectionView.reloadData()
    }
    
    @objc func slideViewPanned() {
        if slideViewPanGesture.state == .ended {
            let velocity = slideViewPanGesture.velocity(in: slideView).y
            gestureDidFinish(velocity: velocity)
            slideViewPanGesture.setTranslation(.zero, in: slideView)
            return
        }
        
        let translation = slideViewPanGesture.translation(in: slideView)
        var newConstant = slideViewTobConstraint.constant - translation.y
        
        if newConstant < minimumSlideViewVisibleHeight {
            newConstant = minimumSlideViewVisibleHeight
        }
        
        if newConstant > maximumSlideViewVisibleHeight {
            newConstant = maximumSlideViewVisibleHeight
        }
        
        slideViewTobConstraint.constant = newConstant
        slideViewPanGesture.setTranslation(.zero, in: slideView)
    }
    
    func gestureDidFinish(velocity: CGFloat) {
        let isDown: Bool = abs(velocity) > 700 ?
            velocity > 0 : slideViewTobConstraint.constant < maximumSlideViewVisibleHeight/2
        
        slideViewTobConstraint.constant = isDown ? minimumSlideViewVisibleHeight : maximumSlideViewVisibleHeight
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IssueDetailAddComment" {
            guard let navController = segue.destination as? UINavigationController,
                  let commentAddViewController = navController.viewControllers.first as? CommentAddViewController else {
                return
            }
            commentAddViewController.delegate = self
        }
    }
}

extension IssueDetailViewController: UICollectionViewDelegate {
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("top offset")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    
}

extension IssueDetailViewController: CommentAddViewControllerDelegate {
    
    func sendButtonDidTouch(text: String) {
        detailCollectionViewAdapter.dataManager.addComment(text: text) { [weak self] isSuccess in
            guard isSuccess,
                  let item = self?.detailCollectionViewAdapter.dataManager.detailItem?.comments.count else {
                return
            }
            self?.detailCollectionView.reloadItems(at: [IndexPath(item: item - 2, section: 0)])
            self?.gestureDidFinish(velocity: 800)
        }
    }
}

extension IssueDetailViewController: IssueDetailSlideViewControllerDelegate {
    
    func issueButtonDidTouch(flag: Bool) {
        detailCollectionViewAdapter.dataManager.setIssueFlag(flag)
        detailCollectionView.reloadSections([0])
        gestureDidFinish(velocity: 800)
    }
    
    func addCommentButtonDidTouch() {
        performSegue(withIdentifier: "IssueDetailAddComment", sender: self)
    }
    
    func moveAboveCellButtonDidTouch() {
        if let topVisibleCell = detailCollectionView.visibleCells.first {
            scrollCell(to: topVisibleCell)
        }
    }
    
    func moveBelowCellButtonDidTouch() {
        if let bottomVisibleCell = detailCollectionView.visibleCells.last {
            scrollCell(to: bottomVisibleCell)
        }
    }
    
    func scrollCell(to cell: UICollectionViewCell) {
        if let indexPath = detailCollectionView.indexPath(for: cell) {
            detailCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
}
