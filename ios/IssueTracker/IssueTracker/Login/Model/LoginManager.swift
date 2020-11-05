//
//  LoginManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/02.
//

import Foundation
import AuthenticationServices

struct LoginManager {
    
    func createAppleOAuthRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        return request
    }
    
    func createGithubOAuthRequestURL() -> URL? {
        var requestURLComponents = URLComponents(string: Constant.URL.githubLogin)
        requestURLComponents?.queryItems = [ URLQueryItem(name: "client_id", value: GithubApplication.ClientID),
                                             URLQueryItem(name: "scope", value: GithubApplication.Scope) ]
        let url = requestURLComponents?.url
        
        return url
    }
}
