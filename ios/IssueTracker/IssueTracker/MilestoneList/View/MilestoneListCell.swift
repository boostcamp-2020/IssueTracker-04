//
//  MilestoneCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

class MilestoneListCell: SwipableCollectionViewCell {
    
    var milestoneView: MilestoneDetailView?
    
    override func commonInit() {
        super.commonInit()
        addMilestoneDetailView()
        addDeleteButton()
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
    
    private func addDeleteButton() {
        guard let rightContainerView = rightContainerView else {
            return
        }
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        rightContainerView.addSubview(button)
        
        let constraints = [button.topAnchor.constraint(equalTo: rightContainerView.topAnchor),
                           button.heightAnchor.constraint(equalTo: rightContainerView.heightAnchor),
                           button.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor),
                           button.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor)]
        NSLayoutConstraint.activate(constraints)
        
        button.backgroundColor = .systemRed
        button.setTitle("Delete", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteButtonDidTouched), for: .touchUpInside)
    }
    
    @objc private func deleteButtonDidTouched() {
    }
    
    func configure(with data: MilestoneDetailViewData) {
        milestoneView?.configure(with: data)
    }
}
