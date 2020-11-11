//
//  FilterCellData.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

class FilterCellData {
    
    enum DataType: Equatable {
        case option(type: OptionType)
        case author(image: String)
        case label(color: String)
        case milestone
        case assignee(image: String)
        
        static func == (lhs: DataType, rhs: DataType) -> Bool {
            switch (lhs, rhs) {
            case (.option(let lhsType), .option(let rhsType)):
                return lhsType == rhsType
            case (.author(_), .author(_)):
                return true
            case (.label(_), .label(_)):
                return true
            case (.milestone, .milestone):
                return true
            case (.assignee(_), .assignee(_)):
                return true
            default:
                return false
            }
        }
    }
    
    enum OptionType {
        case defaultOption
        case author
        case label
        case milestone
        case assignee
        
        var dataType: DataType {
            switch self {
            case .defaultOption:
                return .option(type: .defaultOption)
            case .author:
                return .author(image: "")
            case .label:
                return .label(color: "")
            case .milestone:
                return .milestone
            case .assignee:
                return .assignee(image: "")
            }
        }
    }
    
    init(title: String, type: DataType) {
        self.title = title
        self.type = type
        self.isSelected = false
    }
    
    var title: String
    var type: DataType
    var isSelected: Bool
    
    var query: String {
        switch type {
        case .author:
            return "author:" + title
        case .label:
            return "label:" + title
        case .milestone:
            return "milestone:" + title
        case .assignee:
            return "assignee:" + title
        case .option:
            return ""
        }
    }
}
