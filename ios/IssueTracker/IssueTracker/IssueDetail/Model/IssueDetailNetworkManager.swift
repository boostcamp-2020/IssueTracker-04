//
//  IssueDetailNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/10.
//

import Foundation

struct IssueDetailNetworkManager {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    // - TODO: 네트워크 연결 필요
    func addComment(text: String, completion: @escaping (Result<Comment, NetworkError>) -> Void) {
        let request = NetworkService.Request(method: .put, url: URL(string: ""))
        
        networkService.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let comment = try? JSONDecoder().decode(Comment.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(comment))
            case .failure(let error):
                completion(.failure(error))
            }
            completion(.success(Comment(commentNo: 0, comment: text, authorName: "Test", authorImg: "img", commentDate: Date())))
        }
    }
    
    func requestIssueDetail(completion: (IssueDetail) -> Void) {
//        let request = NetworkService.Request(method: .get, url: URL(""))
//        networkService.request(request: , completion: )
        completion(DummyDataLoader().loadDetail()!)
    }
    
}
