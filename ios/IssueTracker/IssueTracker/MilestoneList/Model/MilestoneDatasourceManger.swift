//
//  MilestoneDatasourceManger.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import Foundation

class MilestoneDatasourceManager {
    var items: [MilestoneDetail] = []
    var itemCount: Int {
        items.count
    }
    
    subscript(indexPath: IndexPath) -> MilestoneDetail {
        items[indexPath.row]
    }
    
    func loadData() {
        items = DummyDataLoader().loadMilestones()
    }
}
