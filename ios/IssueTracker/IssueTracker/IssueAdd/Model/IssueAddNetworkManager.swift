//
//  IssueAddNetworkManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/11.
//

import Foundation

struct IssueAddNetworkManager {
    
    private let service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
}
