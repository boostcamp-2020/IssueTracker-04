//
//  DetailSlideKeyword.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/03.
//

import Foundation

struct DetailSlideKeyword {
    
    enum HeaderSection: Int, CaseIterable {
        
        case assignee
        case label
        case milestone
        case option
        
        var title: String {
            switch self {
            case .assignee: return "Assignees"
            case .label: return "Labels"
            case .milestone: return "Milestone"
            case .option: return ""
            }
        }
        
    }
    
}
