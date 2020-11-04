//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

class IssueDetailViewController: UIViewController {

    let mockData = DetailSlideMockData()
    var gesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var slideViewTobConstraint: NSLayoutConstraint!
    @IBOutlet weak var slideView: IssueDetailSlideView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gesture = UIPanGestureRecognizer(target: self, action: #selector(onAction))
        slideView.addGestureRecognizer(gesture)
        
        slideView.collectionView.delegate = self
        slideView.collectionView.dataSource = self
    }
    
    @objc func onAction() {
        let yLocationTouched = gesture.location(in: self.view).y
//        print("\(yLocationTouched)")

        slideViewTobConstraint.constant = view.frame.height - yLocationTouched
        view.layoutIfNeeded()
    }
}
