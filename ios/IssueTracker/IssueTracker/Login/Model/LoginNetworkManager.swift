//
//  LoginNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/10.
//

import Foundation

class LoginNetworkManager: NetworkManager {
    
    static let userInfoURL = baseURL + "/api/user"
    
    func requestLogin(code: String, completion: @escaping (Result<JWTToken, NetworkError>) -> Void) {
        let bodys = ["client": "ios", "code": code]
        let headers = ["Content-Type": "application/json; charset=utf-8"]
        let json = try? JSONSerialization.data(withJSONObject: bodys)
        
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Constant.URL.baseURL + Constant.URL.code)
        request.headers = headers
        request.body = json
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let token = try? JSONDecoder.custom.decode(JWTToken.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestUserInforamtion(completion: @escaping ((Result<LoginResponse, NetworkError>) -> Void)) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: Self.userInfoURL)
        request.headers = baseHeader
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(LoginResponse.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(response))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
