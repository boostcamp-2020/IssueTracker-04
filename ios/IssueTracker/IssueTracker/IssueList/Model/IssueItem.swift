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
    let issueAuthorID: String
    let milestoneNo: Int
    let milestoneTitle: String
    let assignees: [Assignee]
    let labels: [Label]

    enum CodingKeys: String, CodingKey {
        case issueNo = "issue_no"
        case issueTitle = "issue_title"
        case issueContent = "issue_content"
        case issueFlag = "issue_flag"
        case issueDate = "issue_date"
        case issueAuthorNo = "issue_author_no"
        case issueAuthorID = "issue_author_id"
        case milestoneNo = "milestone_no"
        case milestoneTitle = "milestone_title"
        case assignees, labels
    }
}

struct Assignee: Codable {
    let iuRelationNo, userNo: Int
    let userID, userImg: String

    enum CodingKeys: String, CodingKey {
        case iuRelationNo = "iu_relation_no"
        case userNo = "user_no"
        case userID = "user_id"
        case userImg = "user_img"
    }
}

struct Label: Codable {
    let ilRelationNo, labelNo: Int
    let labelTitle, labelColor: String

    enum CodingKeys: String, CodingKey {
        case ilRelationNo = "il_relation_no"
        case labelNo = "label_no"
        case labelTitle = "label_title"
        case labelColor = "label_color"
    }
}
