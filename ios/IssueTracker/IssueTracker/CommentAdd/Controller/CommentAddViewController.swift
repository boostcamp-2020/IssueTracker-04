//
//  CommentAddViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/10.
//

import UIKit

protocol CommentAddViewControllerDelegate {
    func sendButtonDidTouch(text: String)
}

class CommentAddViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    var delegate: CommentAddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonTouched(_ sender: UIButton) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func sendButtonTouched(_ sender: UIButton) {
        delegate?.sendButtonDidTouch(text: commentTextView.text)
    }
    
}
