//
//  IssueListNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/10.
//

import Foundation

struct IssueAddRequest: Codable {
    let issueTitle: String
    let issueContent: String
}

struct IssueAddResponse: Codable {
    var success: Bool
    var newIssueNo: Int
}

class IssueListNetworkManager: NetworkManager {
    
    static let listRequestURL = baseURL + "/api/issue/list"
    static let addRequestURL = baseURL + "/api/issue"
    
    func requestIssueAdd(issue: IssueAddRequest, completion: @escaping (Result<IssueAddResponse, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Self.addRequestURL)
        request.headers = baseHeader
        let json = try? JSONEncoder.custom.encode(issue)
        request.body = json
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let issueAddData = try? JSONDecoder.custom.decode(IssueAddResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(issueAddData))
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
    
    func requestIssueList(completion: @escaping (Result<[IssueItem], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.listRequestURL)
        request.headers = baseHeader
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let items = try? JSONDecoder.custom.decode([IssueItem].self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(items))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
