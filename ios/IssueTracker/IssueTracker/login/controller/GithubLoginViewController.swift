//
//  GithubLoginViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/10/29.
//

import UIKit

class GithubLoginViewController: UIViewController {
    
    @IBOutlet weak var githubLoginWebView: GithubLoginWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestURL()
    }
    
    func requestURL() {
        let requestURLString = "https://github.com/login/oauth/authorize"
        var requestURLComponents = URLComponents(string: requestURLString)
        
        requestURLComponents?.queryItems = [ URLQueryItem(name: "client_id", value: GithubApplication.ClientID),
                                             URLQueryItem(name: "scope", value: GithubApplication.Scope) ]
        
        let requestURL = requestURLComponents?.url
        
        UIApplication.shared.open(requestURL!)
    }
    
}
