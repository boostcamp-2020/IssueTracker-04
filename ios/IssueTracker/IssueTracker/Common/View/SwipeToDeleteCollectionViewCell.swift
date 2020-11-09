//
//  SwipeToDeleteCollectionViewCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/09.
//

import UIKit

class SwipeToDeleteCollectionViewCell: SwipableCollectionViewCell {
    
    override func commonInit() {
        super.commonInit()
        addDeleteButton()
    }
    
    var deleteHandler: (() -> Void)?
    
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
    
    @objc open func deleteButtonDidTouched() {
        deleteHandler?()
    }
    
    override func didFullSwipe() {
        deleteHandler?()
    }
}
