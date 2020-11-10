//
//  NetworkService.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/09.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case requestFailed(error: Error)
}

class NetworkService {
    
    struct Request {
        var method: RequestMethod
        var url: URL?
        var headers: [String: String]?
        var body: Data?
    }
    
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(request: Request, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = request.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        print(urlRequest.allHTTPHeaderFields)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
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
        }.resume()
    }
    
    func post() {
        
    }
    
}
