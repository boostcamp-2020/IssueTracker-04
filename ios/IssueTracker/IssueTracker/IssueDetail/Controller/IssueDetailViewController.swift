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
    var issueNo: Int = 0
    var detailCollectionViewAdapter: IssueDetailCollectionViewAdapter!
    
    var minimumSlideViewVisibleHeight: CGFloat = 92
    var maximumSlideViewVisibleHeight: CGFloat {
        slideView.frame.height - 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestureRecognizer()
        let networkService = NetworkService()
        let networkManager = IssueDetailNetworkManager(service: networkService, userData: UserData())
        let dataManager = IssueDetailDataSourceManager(networkManager: networkManager)
        detailCollectionViewAdapter = IssueDetailCollectionViewAdapter(dataManager: dataManager)
        
        detailCollectionViewAdapter.dataManager.loadDetailItem(issueNo: issueNo) { result in
            switch result {
            case .success(let _):
                DispatchQueue.main.async { [weak self] in
                    self?.configureCollectionView()
                    self?.detailCollectionView.reloadData()
                    self?.configureSlideView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
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
        
        let networkService = NetworkService()
        let networkManager = DetailEditNetworkManager(service: networkService, userData: UserData())
        
        slideViewController.issueNo = issueNo
        slideViewController.networkManager = networkManager
        slideViewController.adapter = IssueSlideVIewCollectionViewAdapter(dataManager: slideViewDataManager)
        slideViewController.reloadData()
        slideViewPanGesture.delegate = slideViewController
    }
    
    private func configureCollectionView() {
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

extension IssueDetailViewController: CommentAddViewControllerDelegate {
    
    func sendButtonDidTouch(text: String) {
        let user = UserData()
        let comment = Comment(issueNo: issueNo, commentNo: 0, comment: text, authorName: user.name, authorImg: user.image, commentDate: Date())
        detailCollectionViewAdapter.dataManager.addComment(comment: comment) { [weak self] isSuccess in
            guard isSuccess,
                  let commentCount = self?.detailCollectionViewAdapter.dataManager.detailItem?.comments.count else {
                return
            }
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: commentCount - 1, section: 0)
                self?.detailCollectionView.performBatchUpdates({
                    self?.detailCollectionView.insertItems(at: [indexPath])
                }, completion: { _ in
                    self?.detailCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                    self?.gestureDidFinish(velocity: 800)
                })
            }
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
        guard let topIndexPath = detailCollectionView.indexPathsForVisibleItems.min()  else {
            return
        }
        
        if topIndexPath.row == 0 && detailCollectionView.contentOffset.y <= detailCollectionView.cellForItem(at: topIndexPath)?.frame.origin.y ?? 0 {
            detailCollectionView.setContentOffset(.zero, animated: true)
            return
        }
        
        detailCollectionView.scrollToItem(at: IndexPath(row: topIndexPath.row, section: 0), at: .top, animated: true)
    }
    
    func moveBelowCellButtonDidTouch() {
        guard let bottomIndexPath = detailCollectionView.indexPathsForVisibleItems.max() else {
            return
        }
        
        if bottomIndexPath.row + 1 == detailCollectionViewAdapter.dataManager.commentCount {
            return
        }
        
        detailCollectionView.scrollToItem(at: IndexPath(row: bottomIndexPath.row + 1, section: 0), at: .bottom, animated: true)
    }
    
    func scrollCell(to cell: UICollectionViewCell) {
        
    }
    
}
