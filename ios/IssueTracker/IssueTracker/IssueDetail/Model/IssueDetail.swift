//
//  IssueDetail.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/05.
//

import Foundation

struct IssueDetail: Codable {
    var issue: Issue
    let detailInfo: DetailInfo
    let milestone: Milestone
    let labels: [Label]
    let assignees: [Assignee]
    var comments: [Comment]
}

struct Comment: Codable, CommentCellData {
    let issueNo: Int?
    let commentNo: Int
    let comment, authorName, authorImg: String
    let commentDate: Date
}

struct DetailInfo: Codable {
    let authorImg: String
}

struct Issue: Codable {
    let issueNo: Int
    let issueTitle, issueContent: String
    var issueFlag: Int
    let issueDate: Date
    let issueAuthorNo: Int
    let issueAuthorName: String
    
    var isOpen: Bool {
        get {
            issueFlag == 1
        }
        set {
            issueFlag = newValue ? 1 : 0
        }
    }
}

struct Milestone: Codable {
    let milestoneNo: Int
    let milestoneTitle: String
    let milestoneDescription: String?
    let dueDate: Date?
    let percent: Float
    let openIssueCount: Int
    let closedIssueCount: Int
}
