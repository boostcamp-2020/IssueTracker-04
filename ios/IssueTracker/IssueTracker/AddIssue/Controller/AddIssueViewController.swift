//
//  AddIssueViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/04.
//

import UIKit
import WebKit

class AddIssueViewController: UIViewController {
    
    @IBOutlet weak var issueNavItem: IssueNavigationItem!
    
    @IBOutlet weak var markdownTextView: IssueMarkdownTextView!
    @IBOutlet weak var markdownWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markdownWebView.load(URLRequest(url: URL(string: "https://m.naver.com")!))
    }
    
    @IBAction func segmentControlValueChanged(_ segmentControl: UISegmentedControl) {
        let index = segmentControl.selectedSegmentIndex
        let isHiddenView = (index == IssueTextSegmentControl.Index.markdown) ? false : true
        
        markdownTextView.isHidden = isHiddenView
        markdownWebView.isHidden = !isHiddenView
    }
    
}

extension AddIssueViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        addUploadPhotoContextMenu()
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

extension AddIssueViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController(picker, didSelect: info[.originalImage] as? UIImage)
        dismiss(animated: true)
    }
    
}

extension AddIssueViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIMenuController.shared.menuItems = nil
    }
    
}
