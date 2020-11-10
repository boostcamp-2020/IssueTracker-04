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
            presentLoginViewController()
            return
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let context = URLContexts.first,
              let code = context.url.absoluteString.components(separatedBy: "code=").last else {
            return
        }
        NetworkManager.requestLogin(code: code) { result in
            switch result {
            case .success(let data):
                let JWT = String(data: data, encoding: .utf8)
                print(JWT)
            case .failure(let error):
                print(error.localizedDescription)
            }
//            UserDefaults.standard.set(JWT, forKey: "JWT")
//            guard let controller = self.window?.rootViewController as? IssueListViewController else {
//                return
//            }
//            controller.presentingViewController?.dismiss(animated: true)
        }
    }
    
    func presentLoginViewController() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController {
//            loginViewController.modalPresentationStyle = .formSheet
//            loginViewController.isModalInPresentation = true
//            window?.rootViewController?.present(loginViewController, animated: true, completion: nil)
//        }
    }
    
}
