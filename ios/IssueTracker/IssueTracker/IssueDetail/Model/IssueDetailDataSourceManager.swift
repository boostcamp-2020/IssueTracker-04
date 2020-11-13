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
    
    init(networkManager: IssueDetailNetworkManager) {
        self.networkManager = networkManager
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
    
    func loadDetailItem(issueNo: Int, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void) {
        networkManager.requestIssueDetail(issueNo: issueNo) { [weak self] result in
            switch result {
            case .success(let item):
                self?.detailItem = item
                completion(result)
            case .failure(let error):
                completion(result)
                print(error.localizedDescription)
            }
        }
    }
    
    func addComment(comment: Comment, completion: @escaping (Bool) -> Void) {
        networkManager.addComment(comment: comment) { [weak self] result in
            switch result {
            case .success(let comment):
                self?.detailItem?.comments.append(comment)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
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
