//
//  JsonDecoder+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/12.
//

import Foundation

extension JSONDecoder {
    static let custom: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.custom)
        return decoder
    }()
}

extension JSONEncoder {
    static let custom: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(DateFormatter.custom)
        return encoder
    }()
}
