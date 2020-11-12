//
//  ResponseIssueAdd.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/11.
//

import Foundation

struct IssueAddResponse: Codable {
    var success: Bool
    var newIssueNo: Int
}
