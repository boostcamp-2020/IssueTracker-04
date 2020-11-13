//
//  DetailEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

protocol DetailNetworkManager {
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void)
}

struct UserResponse: Codable {
    var success: Bool
    var userList: [User]
}

class AssigneeEditNetworkManager: NetworkManager, DetailNetworkManager {
    
    static let userListRequestURL = baseURL + "/api/userList"
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.userListRequestURL)
        request.headers = baseHeader
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(UserResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                let users = response.userList
                let datas = users.map { DetailEditCellData(type: .assignee(image: $0.userImg), itemId: $0.userNo, title: $0.userName) }
                completion(.success(datas))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct LabelResponse: Codable {
    var success: Bool
    var labels: [Label]
}

class LabelEditNetworkManager: NetworkManager, DetailNetworkManager {
    
    static let labelListRequestURL = baseURL + "/api/labelList"
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.labelListRequestURL)
        request.headers = baseHeader
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(LabelResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                let labels = response.labels
                let datas = labels.map { DetailEditCellData(type: .label(color: $0.labelColor), itemId: $0.labelNo, title: $0.labelTitle) }
                completion(.success(datas))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct MilestoneResponse: Codable {
    var success: Bool
    var milestones: [Milestone]
}

class MilestoneEditNetworkManager: NetworkManager, DetailNetworkManager {
    
    static let milestoneRequestURL = baseURL + "/api/milestoneList"
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.milestoneRequestURL)
        request.headers = baseHeader
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(MilestoneResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                let milestones = response.milestones
                let datas = milestones.map { DetailEditCellData(type: .milestone, itemId: $0.milestoneNo ?? 0, title: $0.milestoneTitle ?? "") }
                completion(.success(datas))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
