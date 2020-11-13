//
//  IssueDetailNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/10.
//

import Foundation

class IssueDetailNetworkManager: NetworkManager {
    
    static let issueDetailRequestURL = baseURL + "/api/issue/"
    static let addCommentRequestURL = baseURL + "/api/comment"
    
    func addComment(comment: Comment, completion: @escaping (Result<Comment, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Self.addCommentRequestURL)
        request.headers = baseHeader
        let commentRequest = AddCommentRequest(issueNo: comment.issueNo ?? 0, comment: comment.comment)
        request.body = try? JSONEncoder.custom.encode(commentRequest)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(AddCommentResponse.self, from: data)
                else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                var addedComment = comment
                addedComment.commentNo = response.commentNo
                completion(.success(addedComment))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestIssueDetail(issueNo: Int, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.issueDetailRequestURL + "\(issueNo)")
        request.headers = baseHeader
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let item = try?  JSONDecoder.custom.decode(IssueDetail.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(item))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct AddCommentResponse: Codable {
    var success: Bool
    var message: String
    var commentNo: Int
}

struct AddCommentRequest: Codable {
    var issueNo: Int
    var comment: String
}
