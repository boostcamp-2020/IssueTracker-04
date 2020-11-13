//
//  LoginManager.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/02.
//

import Foundation
import AuthenticationServices

struct LoginManager {
    
    static let ClientID = "0c86287b9633dd9d529b"
    static let Scope = "read:user,user:email"
    
    func createAppleOAuthRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        return request
    }
    
    func createGithubOAuthRequestURL() -> URL? {
        var requestURLComponents = URLComponents(string: Constant.URL.githubLogin)
        requestURLComponents?.queryItems = [ URLQueryItem(name: "client_id", value: Self.ClientID),
                                             URLQueryItem(name: "scope", value: Self.Scope) ]
        let url = requestURLComponents?.url
        
        return url
    }
}
