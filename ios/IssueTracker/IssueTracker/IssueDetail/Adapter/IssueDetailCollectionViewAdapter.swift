//
//  IssueDetailCollectionViewAdapter.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/04.
//

import UIKit

class IssueDetailCollectionViewAdapter: NSObject, UICollectionViewDataSource {
    
    var dataManager: IssueDetailDataSourceManager
    
    init(dataManager: IssueDetailDataSourceManager) {
        self.dataManager = dataManager
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataManager.commentCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = dataManager[indexPath],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: item)
        cell.cellWidth = collectionView.frame.width
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let item = dataManager.issueInfo,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IssueDetailCollectionViewHeader.identifier, for: indexPath) as? IssueDetailCollectionViewHeader else {
            return UICollectionReusableView()
        }
        
        header.configure(with: item)
        header.viewWidth = collectionView.frame.width
        return header
    }
    
}
