//
//  IssueDetailItem.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import Foundation

struct IssueDetailItem: Codable {
    var issue: IssueItem
    var comments: [CommentItem]
}
