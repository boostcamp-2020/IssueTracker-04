//
//  RequestIssueAdd.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/11.
//

import Foundation

struct IssueAddRequest: Codable {
    let issueTitle: String
    let issueContent: String
}
