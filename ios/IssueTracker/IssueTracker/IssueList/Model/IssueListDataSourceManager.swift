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
    
    func deleteIssue(indexPath: IndexPath) {
        //let issueNo = self[indexPath].issueNo
    }
    
    func deleteIssues(indexPaths: [IndexPath]) {
        //let issueNoList = self[indexPaths].map { $0.issueNo }
    }
    
    func closeIssue(indexPath: IndexPath) {
        //let issueNo = self[indexPath].issueNo
    }
    
    func closeIssues(indexPaths: [IndexPath]) {
        //let issueNoList = self[indexPaths].map { $0.issueNo }
    }
    
}
