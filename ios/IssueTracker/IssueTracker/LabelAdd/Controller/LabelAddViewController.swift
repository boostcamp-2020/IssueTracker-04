//
//  LabelAddViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

protocol LabelDataDelegate: class {
    func labelDidAdd(label: LabelDetail)
    func labelDidUpdate(label: LabelDetail, indexPath: IndexPath)
}

class LabelAddViewController: UIViewController {
    static var identifier: String {
        String(describing: Self.self)
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var colorBox: ColorBox!
    
    weak var delegate: LabelDataDelegate?
    var colorTextFieldManager = ColorTextFieldManager()
    var indexPath: IndexPath?
    var labelData: LabelDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorTextField.delegate = self
        guard let data = labelData else {
            return
        }
        prepareForUpdate(data: data)
    }
    
    private func reset() {
        titleTextField.text = nil
        descriptionTextField.text = nil
        colorTextField.text = nil
    }
    
    func prepareForUpdate(data: LabelDetail) {
        titleTextField.text = data.label.labelTitle
        descriptionTextField.text = data.labelDescription
        colorTextField.text = String(data.label.labelColor.dropFirst())
        colorBox.configure(with: colorTextField.text ?? "")
    }
    
    @IBAction func closeButtonDidTouch(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UIButton) {
        reset()
        colorTextField.text = "FFFFFF"
        colorBox.configure(with: colorTextField.text ?? "")
    }
    
    @IBAction func saveButtonDidTouch(_ sender: UIButton) {
        let label = Label(labelNo: labelData?.label.labelNo ?? 0, labelTitle: titleTextField.text ?? "", labelColor: "#" + (colorTextField.text ?? ""))
        let labelDetail = LabelDetail(label: label, labelDescription: descriptionTextField.text ?? "")
        
        if let indexPath = indexPath {
            delegate?.labelDidUpdate(label: labelDetail, indexPath: indexPath)
        } else {
            delegate?.labelDidAdd(label: labelDetail)
        }
        dismiss(animated: true)
    }
    
    @IBAction func randomButtonTouched(_ sender: UIButton) {
        colorTextField.text = colorTextFieldManager.randomColor()
        colorBox.configure(with: colorTextField.text ?? "")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == view {
            dismiss(animated: true)
        }
    }
}

extension LabelAddViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        colorTextFieldManager.isValidate(text: textField.text, input: string)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        colorBox.configure(with: textField.text ?? "")
    }
}
