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
        guard UserDefaults.standard.string(forKey: "JWT") != nil else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        window?.rootViewController = mainViewController
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let context = URLContexts.first,
              let code = context.url.absoluteString.components(separatedBy: "code=").last else {
            return
        }
        
        let networkService = NetworkService()
        let networkManager = LoginNetworkManager(service: networkService)
        
        networkManager.requestLogin(code: code) { result in
            switch result {
            case .success(let token):
                UserDefaults.standard.set(token.jwt, forKey: "JWT")
                networkManager.requestUserInforamtion { result in
                    switch result {
                    case .success(let response):
                        let user = response.user
                        UserDefaults.standard.set(user.userId, forKey: "UserId")
                        UserDefaults.standard.set(user.userName, forKey: "UserName")
                        UserDefaults.standard.set(user.userNo, forKey: "UserNo")
                        UserDefaults.standard.set(user.userImg, forKey: "UserImage")
                        
                        DispatchQueue.main.async {
                            guard let controller = self.window?.rootViewController as? LoginViewController else {
                                return
                            }
                            controller.loginDidFinish()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
