//
//  IssueDetailNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/10.
//

import Foundation

struct IssueDetailNetworkManager {
    
    static let issueDetailRequestURL = "http://101.101.217.9:5000/api/issue/"
    static let addCommentRequestURL = "http://101.101.217.9:5000/api/comment"
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
   
    func addComment(comment: Comment, completion: @escaping (Result<Comment, NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT"),
              let url = URL(string: Self.addCommentRequestURL) else {
            return
        }
        
        var request = NetworkService.Request(method: .post)
        request.url = url
        request.headers = ["Authorization": "Bearer " + token, "Content-Type": "application/json"]
        let commentRequest = AddCommentRequest(issueNo: comment.issueNo ?? 0, comment: comment.comment)
        request.body = try? JSONEncoder.custom.encode(commentRequest)
        networkService.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(AddCommentResponse.self, from: data)
                else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                let addedComment = Comment(issueNo: comment.issueNo, commentNo: response.commentNo, comment: comment.comment, authorName: comment.authorName, authorImg: comment.authorImg, commentDate: comment.commentDate)
                completion(.success(addedComment))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestIssueDetail(issueNo: Int, completion: @escaping (Result<IssueDetail, NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT"),
              let url = URL(string: Self.issueDetailRequestURL + "\(issueNo)")  else {
            completion(.failure(.invalidURL))
            return
        }
        print(issueNo)
        var request = NetworkService.Request(method: .get)
        request.url = url
        request.headers = ["Authorization": "Bearer " + token]
        networkService.request(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder.custom
                guard let item = try?  decoder.decode(IssueDetail.self, from: data) else {
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
