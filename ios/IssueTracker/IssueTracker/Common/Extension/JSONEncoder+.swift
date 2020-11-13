//
//  JSONEncoder+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/13.
//

import Foundation

extension JSONEncoder {
    static let custom: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(DateFormatter.custom)
        return encoder
    }()
}
