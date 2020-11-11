//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/04.
//

import UIKit
import WebKit

protocol IssueAddViewControllerDelegate: class {
    func issueSendButtonDidTouch(request: RequestIssueAdd)
}

class IssueAddViewController: UIViewController {
    
    @IBOutlet weak var issueNavItem: IssueNavigationItem!
    @IBOutlet weak var issueTitleTextField: IssueTitleTextField!
    @IBOutlet weak var markdownTextView: IssueMarkdownTextView!
    @IBOutlet weak var markdownWebView: WKWebView!
    @IBOutlet weak var markDownTextViewPlaceHolder: UILabel!
    @IBOutlet weak var markdownTextViewBottomConstraint: NSLayoutConstraint!
    
    var markDownRendering: MarkDownRendering?
    var networkManager: IssueAddNetworkManager?
    weak var delegate: IssueAddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = IssueAddNetworkManager()
        markDownRendering = MarkDownRendering()
        addTapToDismissKeyBoard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardHeight = keyboardRectValue.height
        markdownTextViewBottomConstraint.constant = -keyboardHeight + (tabBarController?.tabBar.frame.size.height ?? 0)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        markdownTextViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @IBAction func segmentControlValueChanged(_ segmentControl: UISegmentedControl) {
        let index = segmentControl.selectedSegmentIndex
        let isHiddenView = (index == IssueTextSegmentControl.Index.markdown) ? false : true
        
        if isHiddenView {
            markDownRendering?.renderToHTML(from: markdownTextView.text) { [weak self] html in
                DispatchQueue.main.async {
                    self?.markdownWebView.loadHTMLString(html, baseURL: nil)
                }
            }
        }
        
        markdownTextView.isHidden = isHiddenView
        markdownWebView.isHidden = !isHiddenView
    }
    
    @IBAction func sendButtonTouched(_ sender: Any) {
        guard let title = issueTitleTextField.text,
              let content = markdownTextView.text else {
            return
        }
        delegate?.issueSendButtonDidTouch(request: RequestIssueAdd(issueTitle: title, issueContent: content))
        navigationController?.popViewController(animated: true)
    }
    
}

extension IssueAddViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        markDownTextViewPlaceHolder.isHidden = true
        addUploadPhotoContextMenu()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        markDownTextViewPlaceHolder.isHidden = textView.text?.count != 0
    }
    
    func addUploadPhotoContextMenu() {
        let uploadPhotoMenu = UIMenuItem(title: "Upload photo", action: #selector(uploadPhoto))
        UIMenuController.shared.menuItems = [uploadPhotoMenu]
    }
    
    @objc func uploadPhoto() {
        let controller = UIImagePickerController()
        
        controller.sourceType = .photoLibrary
        controller.delegate = self
        self.present(controller, animated: true)
    }
    
    func imagePickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        dump(image)
    }
    
}

extension IssueAddViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagePickerController(picker, didSelect: info[.originalImage] as? UIImage)
        if let urlString = (info[.imageURL] as? URL)?.absoluteString {
            let markDownString = "![image](\(urlString))"
            markdownTextView.text += markDownString
        }
        dismiss(animated: true)
    }
}

extension IssueAddViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIMenuController.shared.menuItems = nil
    }
}
