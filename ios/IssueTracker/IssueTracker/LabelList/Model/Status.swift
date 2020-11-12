//
//  Status.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/12.
//

import Foundation

struct Status: Codable {
    private(set) var success: Bool
    private(set) var message: String?
}

struct LabelAddStatus: Codable {
    private(set) var success: Bool
    private(set) var message: String?
    private(set) var labelNo: Int
}
