//
//  Notification+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/01.
//

import Foundation

extension Notification.Name {
    //IssueListView
    static let issueDeleteRequested = Notification.Name("IssueDeleteRequested")
    static let issueCloseRequested = Notification.Name("IssueCloseRequested")
    static let issueListSearchRequested = Notification.Name("SearchRequested")
    static let issueListRefreshRequested = Notification.Name("IssueListRefreshRequested")

    //IssueDetailBottomSheet
    static let bottomSheetEditButtonTouched = Notification.Name("BottomSheetEditButtonTouched")
    static let bottomSheetCloseButtonTouched = Notification.Name("BottomSheetCloseButtonTouched")
    
    //LabelListView
    static let labelDeleteRequested = Notification.Name("LabelDeleteRequested")
    
    //MilestoneView
    static let milestoneDeleteRequested = Notification.Name("MilestoneDeleteRequested")
    
}
