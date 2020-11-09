//
//  IssueSlideViewDataSourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/05.
//

import Foundation

class IssueSlideViewDataSourceManager {
    
    enum Section: Int, CaseIterable {
        case assignee
        case label
        case milestone
        case option
        
        var title: String {
            switch self {
            case .assignee:
                return "Assignees"
            case .label:
                return "Labels"
            case .milestone:
                return "Milestone"
            case .option:
                return ""
            }
        }
    }
    
    var assignees: [Assignee] = []
    var labels: [Label] = []
    var milestone: Milestone = Milestone(milestoneNo: 0, milestoneTitle: "")
    var issueFlag: Bool = false
    
    var numberOfSection: Int {
        Section.allCases.count
    }
    
    func count(of section: Int) -> Int {
        
        guard let section = Section(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .assignee:
            return assignees.count
        case .label:
            return labels.count
        case .milestone:
            return 1
        case .option:
            return 1
        }
    }
    
    func title(of indexPath: IndexPath) -> String {
        guard let section = Section(rawValue: indexPath.section) else {
            return ""
        }
        return section.title
    }
    
    func section(of indexPath: IndexPath) -> Section? {
        Section(rawValue: indexPath.section)
    }
    
    func labelTitle(of indexPath: IndexPath) -> String {
        guard let section = Section(rawValue: indexPath.section),
              section == .label else {
            return ""
        }
        
        return labels[indexPath.row].labelTitle
    }
}
