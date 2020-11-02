//
//  IssueListDataSourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/01.
//

import Foundation

class IssueListDataSourceManager {
    
    var items: [IssueItem] = []
    var itemCount: Int {
        items.count
    }
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        loadIssueList()
    }
    
    subscript(indexPath: IndexPath) -> IssueItem {
        items[indexPath.row]
    }
    
    subscript(indexPaths: [IndexPath]) -> [IssueItem] {
        indexPaths.map { self[$0] }
    }
    
    func loadIssueList() {
        items = networkManager.loadItems()
    }
    
    func deleteIssue(by issueNo: Int, completion: (IndexPath) -> Void) {
        guard let index = (items.firstIndex { $0.issueNo == issueNo}) else {
            return
        }
        items.remove(at: index)
        let indexPath = IndexPath(row: index, section: 0)
        completion(indexPath)
    }
    
    func deleteIssues(indexPaths: [IndexPath]) {
        //let issueNoList = self[indexPaths].map { $0.issueNo }
        let deleteIndex = indexPaths.map { $0.row }
        items = items.indices
            .filter { !deleteIndex.contains($0) }
            .map { items[$0] }
    }
    
    func closeIssue(indexPath: IndexPath) {
        //let issueNo = self[indexPath].issueNo
    }
    
    func closeIssues(indexPaths: [IndexPath]) {
        //let issueNoList = self[indexPaths].map { $0.issueNo }
    }
    
}
