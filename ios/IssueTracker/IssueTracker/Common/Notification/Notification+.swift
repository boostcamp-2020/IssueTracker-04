//
//  Notification+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/01.
//

import Foundation

extension Notification.Name {
    static let issueDeleteRequested = Notification.Name("IssueDeleteRequested")
    static let issueCloseRequested = Notification.Name("IssueCloseRequested")
    
    static let labelDeleteRequested = Notification.Name("LabelDeleteRequested")
    
    static let milestoneDeleteRequested = Notification.Name("MilestoneDeleteRequested")
    
    static let searchRequested = Notification.Name("SearchRequested")
}
