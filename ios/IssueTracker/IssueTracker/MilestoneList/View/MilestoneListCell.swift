//
//  MilestoneCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

class MilestoneListCell: SwipeToDeleteCollectionViewCell {
    
    var milestoneView: MilestoneDetailView?
    
    override func commonInit() {
        super.commonInit()
        addMilestoneDetailView()
    }
    
    private func addMilestoneDetailView() {
        guard let mainView = mainView else {
            return
        }
        let milestoneView = MilestoneDetailView()
        milestoneView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(milestoneView)
        
        let constraints = [milestoneView.topAnchor.constraint(equalTo: mainView.topAnchor),
                           milestoneView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
                           milestoneView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                           milestoneView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)]
        NSLayoutConstraint.activate(constraints)
        
        self.milestoneView = milestoneView
    }
    
    func configure(with data: MilestoneDetailViewData) {
        milestoneView?.configure(with: data)
    }
}
