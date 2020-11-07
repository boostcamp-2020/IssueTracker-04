//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/10/28.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var appleLoginButton: AppleIDLoginButton!
    
    private var loginManager: LoginManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppleLoginButton()
        loginManager = LoginManager()
        addTapToDissmissKeyBoard()
    }
    
    private func setAppleLoginButton() {
        appleLoginButton.touchHandler = { [weak self] in
            self?.appleIDButtonTouched()
        }
    }
    
    private func showAppleLoginView(request: ASAuthorizationAppleIDRequest) {
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc func appleIDButtonTouched() {
        guard let request = loginManager?.createAppleOAuthRequest() else {
            return
        }
        showAppleLoginView(request: request)
    }
    
    @IBAction func githubIDButtonTouched(_ sender: UIButton) {
        guard let url = loginManager?.createGithubOAuthRequestURL() else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func loginButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        /// - TODO: 서버에 데이터 전달
        
        saveUserInKeychain(userIdentifier)
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            let identifier = Bundle.main.bundleIdentifier ?? "com.boostcamp.issuetracker04"
            try KeychainItem(service: identifier, account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
    
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}

extension UIViewController {
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController {
            loginViewController.modalPresentationStyle = .formSheet
            loginViewController.isModalInPresentation = true
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
}
