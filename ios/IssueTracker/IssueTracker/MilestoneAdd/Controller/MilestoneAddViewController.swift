//
//  MilestoneAddViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/09.
//

import UIKit

protocol MilestoneDataDelegate: class {
    func milestoneDidAdd(milestoneDetail: Milestone)
    func milestoneDidUpdate(milestoneDetail: Milestone, indexPath: IndexPath)
}

class MilestoneAddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: CusorFixTextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    var indexPath: IndexPath?
    var milestoneData: Milestone?
    weak var delegate: MilestoneDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
        addTapToDismissKeyBoard()
        addKeyboardObserver()
        if let data = milestoneData {
            prepareForUpdate(data: data)
        }
    }
    
    override func keyboardWillShow(keyboardHeight: CGFloat) {
        let topOfkeyboard = view.frame.height - keyboardHeight
        let bottomOfView = containerView.frame.origin.y + containerView.frame.size.height
        
        if bottomOfView > topOfkeyboard {
            containerView.frame.origin.y += topOfkeyboard - bottomOfView
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        containerView.frame.origin.y = view.center.y - containerView.frame.height/2 - 30
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == view {
            dismiss(animated: true)
        }
    }
    
    private func prepareForUpdate(data: Milestone) {
        titleTextField.text = data.milestoneTitle
        descriptionTextField.text = data.milestoneDescription
        dateTextField.text = data.dueDate?.string
    }
    
    @IBAction func closeButtonTouched(_ sender: CancelButton) {
        dismiss(animated: true)
    }
    
    @IBAction func resetButtonTouched(_ sender: UIButton) {
        titleTextField.text = nil
        dateTextField.text = nil
        descriptionTextField.text = nil
    }
    
    @IBAction func saveButtonTouched(_ sender: UIButton) {
        let milestoneDetail = Milestone(milestoneNo: (milestoneData?.milestoneNo) ?? 0,
                                              milestoneTitle: titleTextField.text ?? "",
                                              milestoneDescription: descriptionTextField.text ?? "",
                                              dueDate: Date.create(with: dateTextField.text ?? ""),
                                              percent: milestoneData?.percent ?? 0.0,
                                              openIssueCount: milestoneData?.openIssueCount ?? 0,
                                              closedIssueCount: milestoneData?.closedIssueCount ?? 0)
        if let indexPath = indexPath {
            delegate?.milestoneDidUpdate(milestoneDetail: milestoneDetail, indexPath: indexPath)
        } else {
            delegate?.milestoneDidAdd(milestoneDetail: milestoneDetail)
        }
        dismiss(animated: true)
    }
}

extension MilestoneAddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let shouldWrite =  DateTextFieldManager().isValidate(text: textField.text, input: string)
        var originalText = textField.text
        if (range.location == 4 || range.location == 7) && string != "" {
            originalText?.append("-")
            textField.text = originalText
        }
        return shouldWrite
    }
}
