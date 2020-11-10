//
//  IssueListNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/10.
//

import Foundation

class IssueListNetworkManager {
    
    static let requestURL = "http://101.101.217.9:5000/api/issue/list"
    
    var service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func requestIssueList(completion: @escaping (Result<[IssueItem], NetworkError>) -> Void) {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTm8iOjE5LCJpYXQiOjE2MDQ5ODg3MTEsImV4cCI6MTYwNDk5MjMxMX0.Df4OJLyzpHkYltvg_rN0p397eV72D1ps_eX9kdSIxEk"
        //UserDefault 관리객체 만들어서 토큰 얻어오기
        var request = NetworkService.Request(method: .get)
        request.url = URL(string: IssueListNetworkManager.requestURL)
        request.headers = ["Authorization": "Bearer " + token]
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .formatted(DateFormatter.custom)
                var items = [IssueItem]()
                do {
                    items = try decoder.decode([IssueItem].self, from: data)
                } catch {
                    completion(.failure(NetworkError.invalidData))
                }
                completion(.success(items))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
