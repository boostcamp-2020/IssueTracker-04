//
//  IssueDetailDataSourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/04.
//

import Foundation

struct IssueInfo: DetailHeaderData {
    let issueNo: Int
    let issueTitle, issueContent: String
    let issueFlag: Bool
    let issueDate: Date
    let issueAuthorNo: Int
    let issueAuthorID: String
    
    init(issue: IssueItem) {
        issueNo = issue.issueNo
        issueTitle = issue.issueTitle
        issueContent = issue.issueContent
        issueFlag = issue.issueFlag
        issueDate = issue.issueDate
        issueAuthorNo = issue.issueAuthorNo
        issueAuthorID = issue.issueAuthorID
    }
}

class IssueDetailDataSourceManager {
    
    var detailItem: IssueDetailItem?
    
    var issueInfo: IssueInfo? {
        guard let issue = detailItem?.issue else {
            return nil
        }
        return IssueInfo(issue: issue)
    }
    
    var commentCount: Int {
        detailItem?.comments.count ?? 0
    }
    
    subscript(indexPath: IndexPath) -> CommentItem? {
        return detailItem?.comments[indexPath.row]
    }
}
