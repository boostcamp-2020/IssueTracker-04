//
//  LoginNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/10.
//

import Foundation

class LoginNetworkManager {
    
    static let userInfoURL = "http://101.101.217.9:5000/api/user" 
    
    var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func requestLogin(code: String, completion: @escaping (Result<JWTToken, NetworkError>) -> Void) {
        let bodys = ["client": "ios", "code": code]
        let headers = ["Content-Type": "application/json; charset=utf-8"]
        let json = try? JSONSerialization.data(withJSONObject: bodys)
        let service = NetworkService()
        
        var request = NetworkService.Request(method: .post)
        request.url = URL(string: Constant.URL.baseURL + Constant.URL.code)
        request.headers = headers
        request.body = json
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let token = try? decoder.decode(JWTToken.self, from: data) else {
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
        guard let token = UserDefaults.standard.string(forKey: "JWT") else {
            return
        }
        //UserDefault 관리객체 만들어서 토큰 얻어오기
        var request = NetworkService.Request(method: .get)
        request.url = URL(string: Self.userInfoURL)
        request.headers = ["Authorization": "Bearer " + token]
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .formatted(DateFormatter.custom)
                var response: LoginResponse
                do {
                    response = try decoder.decode(LoginResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(NetworkError.invalidData))
                }
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
