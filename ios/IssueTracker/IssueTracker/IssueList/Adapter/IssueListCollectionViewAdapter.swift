//
//  IssueListCollectionViewAdapter.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

class IssueListCollectionViewAdapter: NSObject, UICollectionViewDataSource {
    
    var items: [IssueItem] = []
    var mode: IssueListViewController.Mode = .normal
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueListCollectionViewCell.identifier, for: indexPath)
        guard let itemCell = cell as? IssueListCollectionViewCell else {
            return cell
        }
        let item = items[indexPath.row]
        itemCell.cellMainWidth = collectionView.frame.width
        itemCell.configure(with: item)
        switch mode {
        case .normal:
            itemCell.showMainView()
        case .edit:
            itemCell.showLeftContainerView()
            let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
            itemCell.isSelected = isSelected
        }
        
        return itemCell
    }
}
