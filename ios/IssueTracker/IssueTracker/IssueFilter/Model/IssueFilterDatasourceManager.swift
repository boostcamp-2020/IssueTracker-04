//
//  IssueFilterDatasourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

class IssueFilterDatasourceManager {
    
    let defaultOptionQuery = ["is:open", "author:@me", "assignee:@me", "comment:@me", "is:close"]
    
    var defaultOptions: [FilterCellData] = [
        FilterCellData(title: "열린 이슈들", type: .option(type: .defaultOption)),
        FilterCellData(title: "내가 작성한 이슈들", type: .option(type: .defaultOption)),
        FilterCellData(title: "나한테 할당된 이슈들", type: .option(type: .defaultOption)),
        FilterCellData(title: "내가 댓글을 남긴 이슈들", type: .option(type: .defaultOption)),
        FilterCellData(title: "닫힌 이슈들", type: .option(type: .defaultOption))
    ]
    var detailOptions: [FilterCellData] = [
        FilterCellData(title: "작성자", type: .option(type: .author)),
        FilterCellData(title: "레이블", type: .option(type: .label)),
        FilterCellData(title: "마일스톤", type: .option(type: .milestone)),
        FilterCellData(title: "담당자", type: .option(type: .assignee))
    ]
    
    var authors: [FilterCellData] = [
        FilterCellData(title: "JK", type: .author(image: "")),
        FilterCellData(title: "Croong", type: .author(image: "")),
        FilterCellData(title: "Honux", type: .author(image: ""))
    ]
    
    var labels: [FilterCellData] = [
        FilterCellData(title: "iOS", type: .label(color: "#AACDED")),
        FilterCellData(title: "WebFE", type: .label(color: "#991DED")),
        FilterCellData(title: "WebBE", type: .label(color: "#AAC119"))
    ]
    
    var milestones: [FilterCellData] = [
        FilterCellData(title: "Week1", type: .milestone),
        FilterCellData(title: "Week2", type: .milestone),
        FilterCellData(title: "Week3", type: .milestone),
        FilterCellData(title: "Week4", type: .milestone),
        FilterCellData(title: "Week5", type: .milestone)
    ]
    
    var assignees: [FilterCellData] = [
        FilterCellData(title: "박제구", type: .assignee(image: "")),
        FilterCellData(title: "오동건", type: .assignee(image: "")),
        FilterCellData(title: "윤병휘", type: .assignee(image: "")),
        FilterCellData(title: "장준영", type: .assignee(image: "")),
        FilterCellData(title: "장규영", type: .assignee(image: ""))
    ]
    
    var searchQuery: String {
        var query: String = ""
        
        query = defaultOptionQuery.enumerated().filter { defaultOptions[$0.offset].isSelected }
        .reduce("") { $0 + " " + $1.element }
        var detail: [FilterCellData] = []
        detail.append(contentsOf: authors)
        detail.append(contentsOf: labels)
        detail.append(contentsOf: milestones)
        detail.append(contentsOf: assignees)
        return detail
            .filter { $0.isSelected }
            .map { $0.query }
            .reduce(query) { $0 + " " + $1 }
    }
    
    subscript(indexPath: IndexPath) -> FilterCellData {
        switch section(of: indexPath) {
        case .defaultOption:
            return defaultOptions[indexPath.row]
        case .detailOption:
            return detailOptions[indexPath.row]
        case .none:
            return FilterCellData(title: "", type: .option(type: .defaultOption))
        }
    }
    
    func subItems(of type: FilterCellData.OptionType) -> [FilterCellData] {
        switch type {
        case .author:
            return authors
        case .label:
            return labels
        case .milestone:
            return milestones
        case .assignee:
            return assignees
        case .defaultOption:
            return defaultOptions
        }
    }
    
    func startIndex(of type: FilterCellData.OptionType) -> Int {
        return detailOptions.firstIndex { $0.type == .option(type: type) } ?? 0
    }
    
    func subIndexPaths(of type: FilterCellData.OptionType) -> [IndexPath] {
        let start = startIndex(of: type)
        return ((start + 1)...(start + subItems(of: type).count)).map { IndexPath(row: $0, section: 1) }
    }
    
    func section(of indexPath: IndexPath) -> FilterSection? {
        FilterSection(rawValue: indexPath.section)
    }
    
    func numberOfRow(in section: Int) -> Int {
        switch FilterSection(rawValue: section) {
        case .defaultOption:
            return defaultOptions.count
        case .detailOption:
            return detailOptions.count
        case .none:
            return 0
        }
    }
    
    func showSubItems(of type: FilterCellData.OptionType) -> [IndexPath] {
        let start = startIndex(of: type)
        detailOptions.insert(contentsOf: subItems(of: type), at: start + 1)
        return subIndexPaths(of: type)
    }
    
    func hideSubItems(of type: FilterCellData.OptionType) -> [IndexPath] {
        detailOptions.removeAll {
            $0.type == type.dataType
        }
        return subIndexPaths(of: type)
    }
}
