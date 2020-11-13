//
//  NetworkService.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/09.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case requestFailed(error: Error)
}

struct NetworkRequest {
    var method: RequestMethod
    var url: URL?
    var headers: [String: String]?
    var body: Data?
}

protocol NetworkProviding {
    func request(request: NetworkRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class NetworkService: NetworkProviding {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(request: NetworkRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = request.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.allHTTPHeaderFields = request.headers
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(NetworkError.requestFailed(error: error)))
                return
            }
            if let response = response as? HTTPURLResponse,
               !((200...299) ~= response.statusCode) {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            completion(.success(data))
        }
        task.resume()
        
    }
}
