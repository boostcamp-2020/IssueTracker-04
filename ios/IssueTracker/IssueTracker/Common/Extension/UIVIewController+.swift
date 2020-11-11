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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
