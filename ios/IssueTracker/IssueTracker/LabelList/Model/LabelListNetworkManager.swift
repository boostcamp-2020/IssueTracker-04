//
//  LabelListNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/12.
//

import Foundation

struct LabelListNetworkManager {
    
    var service: NetworkService
    var loadLabelListUrlString: String = Constant.URL.baseURL + "api/labelList"
    var modifyLabelUrlString: String = Constant.URL.baseURL + "api/label"
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func loadLabelList(completion: @escaping (Result<[Label], NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        let request = NetworkService.Request(method: .get,
                                             url: URL(string: loadLabelListUrlString),
                                             headers: ["Authorization": "Bearer " + token])
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let responseData = try? decoder.decode(LabelListResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(responseData.labels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func add(label: Label, completion: @escaping (Result<Status, NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        let json = try? JSONEncoder.custom.encode(label)
        let request = NetworkService.Request(method: .post,
                                             url: URL(string: modifyLabelUrlString),
                                             headers: ["Content-Type": "application/json",
                                                       "Authorization": "Bearer " + token],
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
    
    func update(label: Label, completion: @escaping (Result<Status, NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        let json = try? JSONEncoder.custom.encode(label)
        let request = NetworkService.Request(method: .put,
                                             url: URL(string: modifyLabelUrlString + "/\(label.labelNo)"),
                                             headers: ["Content-Type": "application/json",
                                                       "Authorization": "Bearer " + token],
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
    
    func delete(labelNo: Int, completion: @escaping (Result<Status, NetworkError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        let request = NetworkService.Request(method: .delete,
                                             url: URL(string: modifyLabelUrlString + "/\(labelNo)"),
                                             headers: ["Content-Type": "application/json",
                                                       "Authorization": "Bearer " + token])
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
