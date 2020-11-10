//
//  CusorFixTextField.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/09.
//

import UIKit

class CusorFixTextField: UITextField {
    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        let start = beginningOfDocument
        let end = position(from: start, offset: text?.count ?? 0)
        return end
    }
}
