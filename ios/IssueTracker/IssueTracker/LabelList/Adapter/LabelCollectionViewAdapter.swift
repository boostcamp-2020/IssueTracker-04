//
//  LabelCollectionViewAdapter.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

class LabelCollectionViewAdapter: NSObject {
    var dataManager: LabelDatasourceManager
    
    init(dataManager: LabelDatasourceManager) {
        self.dataManager = dataManager
        dataManager.loadData()
    }
}

extension LabelCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataManager.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelListCell.identifier, for: indexPath) as? LabelListCell else {
            return UICollectionViewCell()
        }
        let item = dataManager[indexPath]
        cell.configure(with: item)
        cell.deleteHandler = {
            NotificationCenter.default.post(name: .labelDeleteButtonDidTouch, object: nil, userInfo: ["LabelNo": item.label.labelNo])
        }
        return cell
    }
}
