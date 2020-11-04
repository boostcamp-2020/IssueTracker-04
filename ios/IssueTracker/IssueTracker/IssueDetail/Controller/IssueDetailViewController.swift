//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

class IssueDetailViewController: UIViewController {
    
    @IBOutlet weak var slideView: IssueDetailSlideView!
    @IBOutlet weak var detailCollectionView: IssueDetailCollectionView!
    
    @IBOutlet weak var slideViewTobConstraint: NSLayoutConstraint!

    var gesture = UIPanGestureRecognizer()
    var issueTitle: String = "IssueTitle"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gesture = UIPanGestureRecognizer(target: self, action: #selector(onAction))
        slideView.addGestureRecognizer(gesture)
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.setHeaderSize(with: issueTitle, width: detailCollectionView.frame.width)
    }
    
    @objc func onAction() {
        let yLocationTouched = gesture.location(in: self.view).y
        print("\(yLocationTouched)")

        slideViewTobConstraint.constant = view.frame.height - yLocationTouched
        view.layoutIfNeeded()
    }
}

extension IssueDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IssueDetailCollectionViewHeader.identifier, for: indexPath) as? IssueDetailCollectionViewHeader else {
            return UICollectionReusableView()
        }
        header.viewWidth = collectionView.frame.width
        header.issueTitleLabel.text = issueTitle
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
        
        cell.configure()
        cell.cellWidth = collectionView.frame.width
        
        return cell
    }
}
