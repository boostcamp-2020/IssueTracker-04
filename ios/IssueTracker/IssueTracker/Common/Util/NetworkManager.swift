//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/13.
//

import Foundation

class NetworkManager {
    static let baseURL = "http://101.101.217.9:5000"
    
    let service: NetworkProviding
    let userData: UserDataProviding
    
    var baseHeader: [String: String] {
        ["Authorization": "Bearer " + userData.token, "Content-Type": "application/json"]
    }
    
    init(service: NetworkProviding, userData: UserDataProviding) {
        self.service = service
        self.userData = userData
    }
}
