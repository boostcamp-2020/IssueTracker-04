//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

class IssueDetailViewController: UIViewController {

    var gesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var slideView: IssueDetailSlideView!
    @IBOutlet weak var detailCollectionView: IssueDetailCollectionView!
    
    @IBOutlet weak var slideViewTobConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        gesture = UIPanGestureRecognizer(target: self, action: #selector(onAction))
        slideView.addGestureRecognizer(gesture)
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    @objc func onAction() {
        let yLocationTouched = gesture.location(in: self.view).y
        print("\(yLocationTouched)")

        slideViewTobConstraint.constant = view.frame.height - yLocationTouched
        view.layoutIfNeeded()
    }
}

extension IssueDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
