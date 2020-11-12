//
//  LabelListResponse.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/12.
//

import Foundation

struct LabelListResponse: Codable {
    private(set) var success: Bool
    private(set) var labels: [Label]
}
