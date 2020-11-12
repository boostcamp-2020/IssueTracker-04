//
//  MilestoneCollectionViewAdapter.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

class MilestoneCollectionViewAdapter: NSObject {
    var dataManager: MilestoneDatasourceManager
    
    init(dataManager: MilestoneDatasourceManager) {
        self.dataManager = dataManager
    }
}

extension MilestoneCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataManager.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: MilestoneListCell.identifier, for: indexPath) as? MilestoneListCell else {
            return UICollectionViewCell()
        }
        let item = dataManager[indexPath]
        cell.configure(with: item)
        cell.deleteHandler = {
            NotificationCenter.default.post(name: .milestoneDeleteRequested, object: nil, userInfo: ["MilestoneNo": item.milestoneNo])
        }
        return cell
    }
}
