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
    
    private let networkManager: IssueDetailNetworkManager
    
    init(networkManager: IssueDetailNetworkManager = IssueDetailNetworkManager()) {
        self.networkManager = networkManager
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
    // - TODO: UserDefault로 authorName, Img 가져오도록 해야 함
    func addComment(text: String, completion: @escaping (Bool) -> Void) {
        networkManager.addComment(text: text) { [weak self] comment in
            switch comment {
            case .success(let comment):
                self?.detailItem?.comments.append(comment)
                completion(true)
            case .failure(let error):
                completion(false)
            }
            
        }
    }
    
    func setIssueFlag(_ flag: Bool) {
        detailItem?.issue.isOpen = flag
    }
    
    subscript(indexPath: IndexPath) -> Comment? {
        return detailItem?.comments[indexPath.row]
    }
}
