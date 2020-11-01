//
//  IssueListCollectionViewAdapter.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

class IssueListCollectionViewAdapter: NSObject, UICollectionViewDataSource {
    
    var dataSourceManager: IssueListDataSourceManager
    var mode: IssueListViewController.Mode = .normal
    
    init(dataSourceManager: IssueListDataSourceManager) {
        self.dataSourceManager = dataSourceManager
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceManager.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueListCollectionViewCell.identifier, for: indexPath)
        guard let itemCell = cell as? IssueListCollectionViewCell else {
            return cell
        }
        let item = dataSourceManager[indexPath]
        itemCell.cellMainWidth = collectionView.frame.width
        itemCell.configure(with: item)
        itemCell.mode = mode
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
