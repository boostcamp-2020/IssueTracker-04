//
//  DetailEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/12.
//

import Foundation

class DetailEditNetworkManager {
    
    static let labelUpdateRequestURL = "http://101.101.217.9:5000/api/ilrelation"
    
    let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func labelUpdateRequest(issueNo: Int, labels: [Label], completion: @escaping (Bool) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "JWT"),
              let url = URL(string: Self.labelUpdateRequestURL) else {
            return
        }
        var request = NetworkService.Request(method: .post)
        request.url = url
        request.headers = ["Authorization": "Bearer " + token, "Content-Type": "application/json"]
        let labelNos = labels.map { $0.labelNo }
        let updateRequest = LabelUpdateRequest(issueNo: issueNo, labels: labelNos)
        request.body = try? JSONEncoder.custom.encode(updateRequest)
        
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.custom.decode(UpdateResponse.self, from: data),
                      response.success else {
                    completion(false)
                    return
                }
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}

struct LabelUpdateRequest: Codable {
    var issueNo: Int
    var labels: [Int]
}

struct UpdateResponse: Codable {
    var success: Bool
}
