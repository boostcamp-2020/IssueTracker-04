//
//  MilestoneNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/12.
//

import Foundation

struct MilestoneResultResponse: Codable {
    let success: Bool
    let milestoneNo: Int
}

class MilestoneNetworkManager: NetworkManager {
    static let milestoneListRequsetURL = baseURL + "/api/milestoneList"
    static let milestoneModifyRequestURL = baseURL + "/api/milestone"
    
    func load(completion: @escaping (Result<[Milestone], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.milestoneListRequsetURL)
        request.headers = baseHeader
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let milestoneListResponse = try? JSONDecoder.custom.decode(MilestoneResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(milestoneListResponse.milestones))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func add(milestone: Milestone, completion: @escaping (Result<MilestoneResultResponse, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Self.milestoneModifyRequestURL)
        request.headers = baseHeader
        request.body = try? JSONEncoder.custom.encode(milestone)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(MilestoneResultResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(milestone: Milestone, completion: @escaping (Result<MilestoneResultResponse, NetworkError>) -> Void) {
        guard let milstoneNo = milestone.milestoneNo else {
            completion(.failure(.invalidData))
            return
        }
        var request = NetworkRequest(method: .put)
        request.url = URL(string: Self.milestoneModifyRequestURL + "/\(milstoneNo)")
        request.body = try? JSONEncoder.custom.encode(milestone)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(MilestoneResultResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(milestoneNo: Int, completion: @escaping (Result<ResultResponse, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .delete)
        request.url = URL(string: Self.milestoneModifyRequestURL + "/\(milestoneNo)")
        request.headers = baseHeader
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(ResultResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
