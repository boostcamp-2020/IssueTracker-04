//
//  DetailEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

protocol DetailNetworkManager {
    var service: NetworkService { get set }
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void)
}

class AssigneeEditNetworkManager: DetailNetworkManager {
    
    static let requestURL = "http://101.101.217.9:5000/api/userList"
    
    var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT"),
              let url = URL(string: Self.requestURL) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = NetworkService.Request(method: .get)
        request.url = url
        request.headers = ["Authorization": "Bearer " + token]
        
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

class LabelEditNetworkManager: DetailNetworkManager {
    
    static let requestURL = "http://101.101.217.9:5000/api/labelList"
    
    var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT"),
              let url = URL(string: Self.requestURL) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = NetworkService.Request(method: .get)
        request.url = url
        request.headers = ["Authorization": "Bearer " + token]
        
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

class MilestoneEditNetworkManager: DetailNetworkManager {
    
    static let requestURL = "http://101.101.217.9:5000/api/milestoneList"
    
    var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func loadData(completion: @escaping (Result<[DetailEditCellData], NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT"),
              let url = URL(string: Self.requestURL) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = NetworkService.Request(method: .get)
        request.url = url
        request.headers = ["Authorization": "Bearer " + token]
        
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

struct UserResponse: Codable {
    var success: Bool
    var userList: [User]
}

struct MilestoneResponse: Codable {
    var success: Bool
    var milestones: [Milestone]
}

struct LabelResponse: Codable {
    var success: Bool
    var labels: [Label]
}
