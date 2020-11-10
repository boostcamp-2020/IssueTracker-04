//
//  MarkDownRendering.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/07.
//

import Foundation

struct MarkDownRendering {
    
    func renderToHTML(from markdownString: String, compeletion: ((String) -> Void)?) {
        guard let json = try? JSONSerialization.data(withJSONObject: ["text": "\(markdownString)"],
                                                     options: []) else { return }
        let request = NetworkService.Request(method: .post,
                               url: URL(string: "https://api.github.com/markdown"),
                               headers: ["Accept": "application/vnd.github.v3+json"],
                               body: json)
        let service = NetworkService()
        service.request(request: request) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
                    let htmlString = String(decoding: data, as: UTF8.self)
                    
                    compeletion?(headerString + htmlString)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
