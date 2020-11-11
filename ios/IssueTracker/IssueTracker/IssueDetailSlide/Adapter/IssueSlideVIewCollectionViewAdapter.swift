//
//  IssueSlideVIewCollectionViewAdapter.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/06.
//

import UIKit

class IssueSlideVIewCollectionViewAdapter: NSObject, UICollectionViewDataSource {
    
    var dataManager: IssueSlideViewDataSourceManager
    
    init(dataManager: IssueSlideViewDataSourceManager) {
        self.dataManager = dataManager
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataManager.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataManager.count(of: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch dataManager.section(of: indexPath) {
        
        case .assignee, .label, .milestone:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IssueDetailSlideViewHeader.identifier, for: indexPath) as? IssueDetailSlideViewHeader else {
                return UICollectionReusableView()
            }
            header.title.text = dataManager.title(of: indexPath)
            header.buttonHandler = {
                NotificationCenter.default.post(name: .editButtonTouched,
                                                object: nil,
                                                userInfo: ["section": indexPath.section])
            }
            return header
        default:
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EmptyDetailSlideViewHeader", for: indexPath)
        }
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch dataManager.section(of: indexPath) {
        
        case .assignee:
            guard let assigneeCell = collectionView.dequeueReusableCell(withReuseIdentifier: AssigneeCollectionViewCell.identifier, for: indexPath) as? AssigneeCollectionViewCell else {
                return UICollectionViewCell()
            }
            assigneeCell.nameLabel.text = dataManager.assignees[indexPath.row].userName
            return assigneeCell
            
        case .label:
            guard let labelCell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.identifier, for: indexPath) as? LabelCollectionViewCell else {
                return UICollectionViewCell()
            }
            labelCell.setLabel(data: dataManager.labels[indexPath.row])
            return labelCell
            
        case .milestone:
            guard let milestoneCell = collectionView.dequeueReusableCell(withReuseIdentifier: MileStoneCollectionViewCell.identifier, for: indexPath) as? MileStoneCollectionViewCell else {
                return UICollectionViewCell()
            }
            milestoneCell.mileStoneLabel.text = dataManager.milestone.milestoneTitle
            return milestoneCell
            
        case .option:
            guard let optionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClosedCollectionViewCell.identifier, for: indexPath) as? ClosedCollectionViewCell else {
                return UICollectionViewCell()
            }
            optionCell.touchHandler = { [weak self] in
                if let flag = self?.dataManager.issueFlag {
                    optionCell.setClosedButtonLabel(flag: !flag)
                }
                NotificationCenter.default.post(name: .closedButtonTouched,
                                                object: nil)
            }
            return optionCell
        case .none:
            return UICollectionViewCell()
        }
    }
    
}
