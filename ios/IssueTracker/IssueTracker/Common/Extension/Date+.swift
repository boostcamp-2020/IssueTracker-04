//
//  Date+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import Foundation

extension Date {
    
    static let formatter = DateFormatter()
    
    var string: String {
        Date.formatter.dateFormat = "yyyy-MM-dd"
        return Date.formatter.string(from: self)
    }
}
