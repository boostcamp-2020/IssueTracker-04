//
//  IssueItem.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import Foundation

struct IssueItem: Codable, IssueListCollectionViewCellData {
    let issueNo: Int
    let issueTitle, issueContent: String
    let issueFlag: Bool
    let issueDate: Date
    let issueAuthorNo: Int
    let issueAuthorId: String
    let milestoneNo: Int
    let milestoneTitle: String
    let assignees: [Assignee]
    let labels: [Label]
}

struct Assignee: Codable {
    let iuRelationNo, userNo: Int
    let userName, userImg: String
}

struct Label: Codable {
    let ilRelationNo, labelNo: Int
    let labelTitle, labelColor: String
}
