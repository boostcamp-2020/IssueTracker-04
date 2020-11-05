//
//  MileStone.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/03.
//

import Foundation

struct MileStone: Codable {
    
    private(set) var milestoneID: String
    private(set) var milestoneTitle: String
    private(set) var milestoneDesc: String?
    private(set) var dueDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case milestoneID = "milestone_no"
        case milestoneTitle = "milestone_title"
        case milestoneDesc = "milestone_description"
        case dueDate = "due_date"
    }
    
}
