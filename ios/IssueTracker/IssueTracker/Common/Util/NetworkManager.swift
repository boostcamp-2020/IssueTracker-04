//
//  NetworkManagers.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/02.
//

import Foundation

final class NetworkManager {
    
    private init() { }
    
    static func requestLogin(code: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        let bodys = ["client": "ios", "code": code]
        let headers = ["Content-Type": "application/json; charset=utf-8"]
        let json = try? JSONSerialization.data(withJSONObject: bodys)
        let service = NetworkService()
        
        service.request(request: .init(method: .post,
                                       url: URL(string: Constant.URL.baseURL + Constant.URL.code),
                                       headers: headers,
                                       body: json)) { result in
            completionHandler(result)
        }
    }
    
}
