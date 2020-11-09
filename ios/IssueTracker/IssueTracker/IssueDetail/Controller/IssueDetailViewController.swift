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
        slideView.addGestureRecognizer(slideViewPanGesture)
    }
    
    private func configureSlideView() {
        guard let slideViewController = children.first as? IssueDetailSlideViewController,
              let detailItem = detailCollectionViewAdapter.dataManager.detailItem else {
            return
        }
        
        let slideViewDataManager = IssueSlideViewDataSourceManager()
        slideViewDataManager.assignees = detailItem.assignees
        slideViewDataManager.labels = detailItem.labels
        slideViewDataManager.milestone = detailItem.milestone
        
        slideViewController.adapter = IssueSlideVIewCollectionViewAdapter(dataManager: slideViewDataManager)
        slideViewController.reloadData()
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
}

extension IssueDetailViewController: UICollectionViewDelegate {
    
}
