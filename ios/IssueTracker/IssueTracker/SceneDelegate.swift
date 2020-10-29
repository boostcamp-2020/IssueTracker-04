//
//  SceneDelegate.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/10/27.
//

import UIKit
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        checkCredentialState()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        URLContexts.forEach { URLContext in
            let code = URLContext.url.absoluteString.components(separatedBy: "code=").last ?? ""
            requestAccessToken(code: code)
        }
    }
    
    func requestAccessToken(code: String) {
        let requestURLString = "https://github.com/login/oauth/access_token"
        var requestURLComponents = URLComponents(string: requestURLString)
        
        requestURLComponents?.queryItems = [ URLQueryItem(name: "client_id", value: GithubApplication.ClientID),
                                             URLQueryItem(name: "client_secret", value: GithubApplication.ClientSecret),
                                             URLQueryItem(name: "code", value: code) ]
        
        let requestUrl = requestURLComponents!.url!
        
        URLSession(configuration: .default).dataTask(with: requestUrl) { (data, response, error) in
            print(String(data: data!, encoding: .utf8))
            print(response?.description)
            print(error?.localizedDescription)
        }.resume()
    }
    
    func checkCredentialState() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                DispatchQueue.main.async {
                    self.window?.rootViewController?.showLoginViewController()
                }
            default:
                break
            }
        }
    }
}

