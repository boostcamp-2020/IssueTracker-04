//
//  DetailEditCellData.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

struct DetailEditCellData {
    
    enum DataType {
        case assignee(image: String)
        case label(color: String)
        case milestone
    }
    
    let type: DataType
    let itemId: Int
    let title: String
    
    var rawData: String {
        switch self.type {
        case .assignee(let image):
            return image
        case .label(let color):
            return color
        case .milestone:
            return ""
        }
    }
}
