//
//  MarkDownRendering.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/07.
//

import Foundation

struct MarkDownRendering {
    
    func renderToHTML(from markdownString: String, compeletion: ((String) -> Void)?) {
        guard let url = URL(string: "https://api.github.com/markdown") else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        guard let json = try? JSONSerialization.data(withJSONObject: ["text": "\(markdownString)"
    ], options: []) else { return }
        request.httpBody = json

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299) ~= response.statusCode,
                error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
            let htmlString = String(decoding: data, as: UTF8.self)
            
            compeletion?(headerString + htmlString)
        }
        task.resume()
    }
}
