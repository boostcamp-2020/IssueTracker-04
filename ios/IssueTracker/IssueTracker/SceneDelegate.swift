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
        guard let context = URLContexts.first,
              let code = context.url.absoluteString.components(separatedBy: "code=").last else {
            return
        }
        NetworkManagers.requestLogin(code: code) { (data, error) in
            guard let data = data,
                  let JWT = String(data: data, encoding: .utf8) else {
                return
            }
            UserDefaults.standard.set(JWT, forKey: "JWT")
        }
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
