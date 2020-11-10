//
//  MilestoneDetail.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import Foundation

struct MilestoneDetail: Codable, MilestoneDetailViewData {
    var milestoneNo: Int
    var milestoneTitle: String
    var dueDate: Date?
    var milestoneDescription: String
    var percent: Float
    var openIssueCount: Int
    var closedIssueCount: Int
}
