//
//  IssueDetailSlideViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/05.
//

import UIKit

class IssueDetailSlideViewController: UIViewController {

    let mockData = DetailSlideMockData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension IssueDetailSlideViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssueDetailSlideViewHeader", for: indexPath) as? IssueDetailSlideViewHeader,
              indexPath.section != DetailSlideKeyword.HeaderSection.option.rawValue else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyDetailSlideViewHeader", for: indexPath)
        }
        cell.setHeader(title: DetailSlideKeyword.HeaderSection.allCases[indexPath.section].title)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DetailSlideKeyword.HeaderSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case DetailSlideKeyword.HeaderSection.assignee.rawValue:
            return mockData.assignees.count
        case DetailSlideKeyword.HeaderSection.label.rawValue:
            return mockData.labels.count
        case DetailSlideKeyword.HeaderSection.milestone.rawValue:
            return mockData.mileStone.count
        case DetailSlideKeyword.HeaderSection.option.rawValue:
            return 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        switch indexPath.section {
        case DetailSlideKeyword.HeaderSection.assignee.rawValue:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssigneeCollectionViewCell", for: indexPath)
        case DetailSlideKeyword.HeaderSection.label.rawValue:
            guard let labelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell", for: indexPath) as? LabelCollectionViewCell else {
                return UICollectionViewCell()
            }
            labelCell.setLabel(data: mockData.labels[indexPath.item])
            return labelCell
        case DetailSlideKeyword.HeaderSection.milestone.rawValue:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MileStoneCollectionViewCell", for: indexPath)
        case DetailSlideKeyword.HeaderSection.option.rawValue:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyDetailSlideViewHeader", for: indexPath)
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyDetailSlideViewHeader", for: indexPath)
        }
        
        return cell
    }
}

extension IssueDetailSlideViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 58)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case DetailSlideKeyword.HeaderSection.assignee.rawValue,
             DetailSlideKeyword.HeaderSection.option.rawValue:
            return CGSize(width: collectionView.frame.width, height: 48)
        case DetailSlideKeyword.HeaderSection.label.rawValue:
            let width = mockData.labels[indexPath.item].labelTitle.estimatedLabelWidth(height: 30, fontSize: 17)
            return CGSize(width: width + 12, height: 30)
        case DetailSlideKeyword.HeaderSection.milestone.rawValue:
            return CGSize(width: collectionView.frame.width, height: 120)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == DetailSlideKeyword.HeaderSection.label.rawValue {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}
