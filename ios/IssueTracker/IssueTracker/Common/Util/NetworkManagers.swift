//
//  NetworkManagers.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/02.
//

import Foundation
import Alamofire

final class NetworkManagers {
    
    private init() { }
    
    static func requestLogin(code: String, completionHandler: @escaping (Data?, AFError?) -> Void) {
        let params = ["code" : code, "client" : "ios"]
        AF.request(Constant.URL.baseURL + Constant.URL.code, method: .post, parameters: params).response { response in
            completionHandler(response.data, response.error)
        }
    }
    
}
