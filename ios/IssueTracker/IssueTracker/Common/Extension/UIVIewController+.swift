//
//  UIVIewController+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/07.
//

import UIKit

extension UIViewController {
    func addTapToDismissKeyBoard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardHeight = keyboardRectValue.height - (tabBarController?.tabBar.frame.size.height ?? 0)
        keyboardWillShow(keyboardHeight: keyboardHeight)
    }
    
    @objc func keyboardWillShow(keyboardHeight: CGFloat) {
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
}
