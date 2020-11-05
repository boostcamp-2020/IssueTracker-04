//
//  AppleIDLoginButton.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/02.
//
import UIKit
import AuthenticationServices

@IBDesignable
class AppleIDLoginButton: ASAuthorizationAppleIDButton {
    
    var touchHandler: (() -> Void)?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchHandler?()
    }
    
}
