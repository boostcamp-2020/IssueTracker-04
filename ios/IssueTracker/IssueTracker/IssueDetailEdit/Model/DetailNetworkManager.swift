//
//  DetailEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

protocol DetailNetworkManager {
    var service: NetworkService { get set }
    func loadData() -> [DetailEditCellData] // 핸들러로 변경
}

class AssigneeEditNetworkManager: DetailNetworkManager {
    var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func loadData() -> [DetailEditCellData] {
        return [
            DetailEditCellData(type: .assignee(image: ""), itemId: 0, title: "JK"),
            DetailEditCellData(type: .assignee(image: ""), itemId: 1, title: "Honux"),
            DetailEditCellData(type: .assignee(image: ""), itemId: 2, title: "Croong")]
    }
}

class LabelEditNetworkManager: DetailNetworkManager {
    var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func loadData() -> [DetailEditCellData] {
        return [
            DetailEditCellData(type: .label(color: "#DE45DE"), itemId: 0, title: "iOS"),
            DetailEditCellData(type: .label(color: "#ACDCDE"), itemId: 1, title: "Client"),
            DetailEditCellData(type: .label(color: "#12A5DE"), itemId: 2, title: "Server")]
    }
}

class MilestoneEditNetworkManager: DetailNetworkManager {
    var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func loadData() -> [DetailEditCellData] {
        return [
            DetailEditCellData(type: .milestone, itemId: 0, title: "Week1"),
            DetailEditCellData(type: .milestone, itemId: 1, title: "Week2"),
            DetailEditCellData(type: .milestone, itemId: 2, title: "Week3"),
            DetailEditCellData(type: .milestone, itemId: 0, title: "Week4"),
            DetailEditCellData(type: .milestone, itemId: 1, title: "Week5"),
            DetailEditCellData(type: .milestone, itemId: 2, title: "Week6")]
    }
}
