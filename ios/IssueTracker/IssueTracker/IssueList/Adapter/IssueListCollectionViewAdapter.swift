//
//  IssueListCollectionViewAdapter.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

class IssueListCollectionViewAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var items: [IssueItem] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IssueListCollectionViewCell.identifier, for: indexPath)
        guard let itemCell = cell as? IssueListCollectionViewCell else {
            return cell
        }
        let item = items[indexPath.row]
        itemCell.cellWidth = collectionView.frame.width
        itemCell.configure(with: item)
        return itemCell
    }
}
