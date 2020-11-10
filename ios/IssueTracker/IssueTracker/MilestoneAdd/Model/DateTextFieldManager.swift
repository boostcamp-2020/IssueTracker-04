//
//  DateTextFieldManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/09.
//

import Foundation

struct DateTextFieldManager {
    
    var allowedCharacterSet = CharacterSet.decimalDigits
    
    func isValidate(text: String?, input: String) -> Bool {
        if input == "" {
            return true
        }
        
        if (text?.count ?? 0) >= 10 {
            return false
        }
        return input.rangeOfCharacter(from: allowedCharacterSet) == nil ? false : true
    }
}
