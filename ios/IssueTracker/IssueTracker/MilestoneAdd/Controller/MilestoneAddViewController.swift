//
//  MilestoneAddViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/09.
//

import UIKit

protocol MilestoneDataDelegate: class {
    func milestoneDidAdd(milestoneDetail: MilestoneDetail)
    func milestoneDidUpdate(milestoneDetail: MilestoneDetail, indexPath: IndexPath)
}

class MilestoneAddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: CusorFixTextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var indexPath: IndexPath?
    var milestoneData: MilestoneDetail?
    weak var delegate: MilestoneDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
        addTapToDissmissKeyBoard()
        if let data = milestoneData {
            prepareForUpdate(data: data)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == view {
            dismiss(animated: true)
        }
    }
    
    private func prepareForUpdate(data: MilestoneDetail) {
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
        let milestoneDetail = MilestoneDetail(milestoneNo: milestoneData?.milestoneNo ?? 0,
                                              milestoneTitle: titleTextField.text ?? "",
                                              dueDate: Date.make(string: dateTextField.text ?? ""),
                                              milestoneDescription: descriptionTextField.text ?? "",
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
