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
    
    func add(label: LabelDetail, completion: ((IndexPath) -> Void)?) {
        //api add
        //api response == 200
        items.append(label)
        completion?(IndexPath(row: items.count - 1, section: 0))
    }
    
    func update(label: LabelDetail, indexPath: IndexPath, completion: ((IndexPath) -> Void)?) {
        guard label.label.labelNo == self[indexPath].label.labelNo else {
            return
        }
        //api add
        //api response == 200
        items[indexPath.row] = label
        completion?(indexPath)
    }
    
    func delete(with labelNo: Int, completion: ((IndexPath) -> Void)?) {
        //self[indexPath].label.labelNo
        guard let index = (items.firstIndex { $0.label.labelNo == labelNo }) else {
            return
        }
        items.remove(at: index)
        completion?(IndexPath(row: index, section: 0))
    }
}
