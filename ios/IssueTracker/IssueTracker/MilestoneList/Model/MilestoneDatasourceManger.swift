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
    
    func add(item: MilestoneDetail, completion: ((IndexPath) -> Void)?) {
        //api add
        //api response == 200
        items.append(item)
        completion?(IndexPath(row: items.count - 1, section: 0))
    }
    
    func update(item: MilestoneDetail, indexPath: IndexPath, completion: ((IndexPath) -> Void)?) {
        guard item.milestoneNo == self[indexPath].milestoneNo else {
            return
        }
        //api add
        //api response == 200
        items[indexPath.row] = item
        completion?(indexPath)
    }
    
    func delete(with milestoneNo: Int, completion: ((IndexPath) -> Void)?) {
        //self[indexPath].label.labelNo
        guard let index = (items.firstIndex { $0.milestoneNo == milestoneNo }) else {
            return
        }
        items.remove(at: index)
        completion?(IndexPath(row: index, section: 0))
    }
}
