//
//  LableListCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

protocol LabelListCellData {
    var label: Label { get }
    var labelDescription: String { get }
}

class LabelListCell: SwipeToDeleteCollectionViewCell {
    
    var badgeLabel: BadgeLabel?
    var descriptionLabel: UILabel?
    
    override func commonInit() {
        super.commonInit()
        addBadgeLabel()
        addDescriptionLabel()
        addAccessory()
    }
    
    override func prepareForReuse() {
        mainLeadingConstraint?.constant = 0
        layoutIfNeeded()
    }
    
    private func addBadgeLabel() {
        guard let mainView = mainView else {
            return
        }
        let label = BadgeLabel(text: "", backgroundColor: .clear)
        label.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(label)
        
        let constraints = [label.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
                           label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
        badgeLabel = label
    }
    
    private func addDescriptionLabel() {
        guard let mainView = mainView,
              let badgeLabel = badgeLabel else {
            return
        }
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(label)
        
        let constraints = [label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
                           label.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 16),
                           label.topAnchor.constraint(greaterThanOrEqualTo: badgeLabel.bottomAnchor, constant: 8),
                           label.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8)]
        NSLayoutConstraint.activate(constraints)
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray2
        descriptionLabel = label
    }
    
    private func addAccessory() {
        guard let mainView = mainView else {
            return
        }
        let accessory = UIImageView()
        accessory.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(accessory)
        
        let constraints = [accessory.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
                           accessory.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
                           accessory.widthAnchor.constraint(equalToConstant: 12),
                           accessory.heightAnchor.constraint(equalToConstant: 12)]
        NSLayoutConstraint.activate(constraints)
        
        accessory.image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold))
        accessory.tintColor = .systemGray2
    }
    
    func configure(with data: LabelListCellData) {
        badgeLabel?.configure(with: data.label)
        descriptionLabel?.text = data.labelDescription
    }
}
