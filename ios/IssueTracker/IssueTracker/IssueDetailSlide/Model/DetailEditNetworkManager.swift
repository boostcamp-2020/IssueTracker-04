//
//  DetailEditNetworkManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/12.
//

import Foundation

struct LabelUpdateRequest: Codable {
    var issueNo: Int
    var labels: [Int]
}

struct UpdateResponse: Codable {
    var success: Bool
}

class DetailEditNetworkManager: NetworkManager {
    
    static let labelUpdateRequestURL = baseURL + "/api/ilrelation"
  
    func labelUpdateRequest(issueNo: Int, labels: [Label], completion: @escaping (Bool) -> Void) {
        var request = NetworkRequest(method: .post)
        request.url = URL(string: Self.labelUpdateRequestURL)
        request.headers = baseHeader
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
