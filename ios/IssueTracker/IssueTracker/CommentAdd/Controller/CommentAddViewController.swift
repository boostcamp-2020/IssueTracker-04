//
//  CommentAddViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/10.
//

import UIKit

protocol CommentAddViewControllerDelegate: class {
    func sendButtonDidTouch(text: String)
}

class CommentAddViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var textViewBottomConstant: NSLayoutConstraint!
    
    weak var delegate: CommentAddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapToDismissKeyBoard()
        addKeyboardObserver()
    }
    
    override func keyboardWillShow(keyboardHeight: CGFloat) {
        textViewBottomConstant.constant = keyboardHeight
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    override func keyboardWillHide(notification: NSNotification) {
        textViewBottomConstant.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @IBAction func cancelButtonTouched(_ sender: UIButton) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func sendButtonTouched(_ sender: UIButton) {
        delegate?.sendButtonDidTouch(text: commentTextView.text)
        navigationController?.dismiss(animated: true)
    }
    
}
