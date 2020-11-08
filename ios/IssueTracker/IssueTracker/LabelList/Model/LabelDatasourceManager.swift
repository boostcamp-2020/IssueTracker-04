//
//  LabelDatasourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import Foundation

class LabelDatasourceManager {
    var items: [LabelDetail] = []
    var itemCount: Int {
        items.count
    }
    
    subscript(indexPath: IndexPath) -> LabelDetail {
        items[indexPath.row]
    }
    
    func loadData() {
        items = DummyDataLoader().loadLabels()
    }
}
