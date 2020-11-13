//
//  Date+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import Foundation

extension Date {
    
    static let formatter = DateFormatter()
    
    static func create(with string: String) -> Date? {
        return Date.formatter.date(from: string)
    }
    
    var string: String {
        Date.formatter.dateFormat = "yyyy-MM-dd"
        return Date.formatter.string(from: self)
    }
    
    func difference(with fromDate: Date) -> String {
        let sec = Int64(self.timeIntervalSince(fromDate))
        
        if sec > 31536000 * 3 {
            return fromDate.string
        }
        
        if sec < 5 {
            return "now"
        }
        
        if sec < 60 {
            return "\(sec) seconds ago"
        }
        
        if sec < 3600 {
            return "\(sec/60) minutes ago"
        }
        
        if sec < 86400 {
            return "\(sec/3600) hours ago"
        }
        
        if sec < 604800 {
            return "\(sec/86400) days ago"
        }
        
        if sec < 2592000 {
            return "\(sec/604800) weeks ago"
        }
        
        if sec < 31536000 {
            return "\(sec/2592000) months ago"
        }
        
        return "\(sec/31536000) years ago"
    }
}
