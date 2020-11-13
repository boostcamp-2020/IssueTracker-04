//
//  LabelListNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/12.
//

import Foundation

struct ResultResponse: Codable {
    private(set) var success: Bool
    private(set) var message: String?
}

struct LabelAddResultResponse: Codable {
    private(set) var success: Bool
    private(set) var message: String?
    private(set) var labelNo: Int
}

class LabelListNetworkManager: NetworkManager {
    
    static let labelListRequestURL = baseURL + "/api/labelList"
    static let labelModifyRequestUrl = baseURL + "/api/label"
    
    func loadLabelList(completion: @escaping (Result<[Label], NetworkError>) -> Void) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.labelListRequestURL)
        request.headers = baseHeader
    
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let responseData = try? JSONDecoder.custom.decode(LabelResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(responseData.labels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func add(label: Label, completion: @escaping (Result<LabelAddResultResponse, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Self.labelModifyRequestUrl)
        request.headers = baseHeader
        request.body = try? JSONEncoder.custom.encode(label)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let status = try? JSONDecoder.custom.decode(LabelAddResultResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(status))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(label: Label, completion: @escaping (Result<ResultResponse, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .put)
        request.url = URL(string: Self.labelModifyRequestUrl + "/\(label.labelNo)")
        request.headers = baseHeader
        request.body = try? JSONEncoder.custom.encode(label)
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let status = try? JSONDecoder.custom.decode(ResultResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(status))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(labelNo: Int, completion: @escaping (Result<ResultResponse, NetworkError>) -> Void) {
        var request = NetworkRequest(method: .delete)
        request.url = URL(string: Self.labelModifyRequestUrl + "/\(labelNo)")
        request.headers = baseHeader
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let status = try? JSONDecoder.custom.decode(ResultResponse.self, from: data) else {
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
