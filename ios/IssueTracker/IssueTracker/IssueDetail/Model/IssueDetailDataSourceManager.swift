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
    let isOpen: Bool
    let issueDate: Date
    let issueAuthorNo: Int
    let issueAuthorID: String
    
    init(detail: IssueDetail) {
        issueNo = detail.issue.issueNo
        issueTitle = detail.issue.issueTitle
        issueContent = detail.issue.issueContent
        isOpen = detail.issue.isOpen
        issueDate = detail.issue.issueDate
        issueAuthorNo = detail.issue.issueAuthorNo
        issueAuthorID = detail.issue.issueAuthorName
    }
}

class IssueDetailDataSourceManager {
    
    init() {
        detailItem = DummyDataLoader().loadDetail()
    }
    
    var detailItem: IssueDetail?
    
    var issueInfo: IssueInfo? {
        guard let detail = detailItem else {
            return nil
        }
        return IssueInfo(detail: detail)
    }
    
    var commentCount: Int {
        detailItem?.comments.count ?? 0
    }
    
    func setIssueFlag(_ flag: Bool) {
        detailItem?.issue.isOpen = flag
    }
    
    subscript(indexPath: IndexPath) -> Comment? {
        return detailItem?.comments[indexPath.row]
    }
}
