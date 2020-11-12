//
//  LoginResponse.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/12.
//

import Foundation

struct LoginResponse: Codable {
    var success: Bool
    var user: User
}

struct User: Codable {
    var userNo: Int
    var userId: String
    var userImg: String
    var userName: String
}
