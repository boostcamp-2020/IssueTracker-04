//
//  MilestoneNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/12.
//

import Foundation

struct MilestoneNetworkManager {
    
    private let service: NetworkService
    private let loadMilestoneUrlString = Constant.URL.baseURL + "api/milestoneList"
    private let modifyMilestoneUrlString = Constant.URL.baseURL + "api/milestone"
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func load(completion: @escaping (Result<[Milestone], NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        let request = NetworkService.Request(method: .get,
                                             url: URL(string: loadMilestoneUrlString),
                                             headers: ["Authorization": "Bearer " + token])
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let milestoneListResponse = try? JSONDecoder.custom.decode(MilestoneListResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(milestoneListResponse.milestones))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func add(milestone: Milestone, completion: @escaping (Result<Status, NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        let json = try? JSONEncoder.custom.encode(milestone)
        let request = NetworkService.Request(method: .post,
                                             url: URL(string: modifyMilestoneUrlString),
                                             headers: ["Authorization": "Bearer " + token,
                                                       "Content-Type": "application/json"],
                                             body: json)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let status = try? JSONDecoder.custom.decode(Status.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(status))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(milestone: Milestone, completion: @escaping (Result<Status, NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        let json = try? JSONEncoder.custom.encode(milestone)
        let request = NetworkService.Request(method: .put,
                                             url: URL(string: modifyMilestoneUrlString + "/\(milestone.milestoneNo)"),
                                             headers: ["Authorization": "Bearer " + token,
                                                       "Content-Type": "application/json"],
                                             body: json)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let status = try? JSONDecoder.custom.decode(Status.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(status))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(milestoneNo: Int, completion: @escaping (Result<Status, NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        let request = NetworkService.Request(method: .delete,
                                             url: URL(string: modifyMilestoneUrlString + "/\(milestoneNo)"),
                                             headers: ["Authorization": "Bearer " + token,
                                                       "Content-Type": "application/json"])
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let status = try? JSONDecoder.custom.decode(Status.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(status))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
