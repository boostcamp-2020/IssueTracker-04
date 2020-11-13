//
//  ColorTextFieldManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import Foundation

struct ColorTextFieldManager {
    let allowedCharacters = "1234567890abcdefABCDEF"
    var allowedCharacterSet: CharacterSet {
        CharacterSet(charactersIn: allowedCharacters)
    }
    
    func isValidate(text: String?, input: String) -> Bool {
        if input == "" {
            return true
        }
        
        if (text?.count ?? 0) >= 6 {
            return false
        }
        return input.rangeOfCharacter(from: allowedCharacterSet) == nil ? false : true
    }
    
    func randomColor() -> String {
        String((0..<6).map { _ in allowedCharacters.randomElement() ?? "0" })
    }
}
