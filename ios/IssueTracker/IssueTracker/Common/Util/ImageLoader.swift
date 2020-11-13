//
//  ImageLoader.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/13.
//

import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
    private init() { }
    
    private let networkService = NetworkService()
    
    func load(url: String, to imageView: UIImageView) {
        var request = NetworkRequest(method: .get)
        request.url = URL(string: url)
        
        networkService.request(request: request) { result in
            var image: UIImage?
            switch result {
            case .success(let data):
                image = UIImage(data: data)
                if image == nil {
                    image = UIImage(systemName: "person.circle.fill")
                }
            case .failure(_):
                image = UIImage(systemName: "person.circle.fill")
            }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    
    
}
