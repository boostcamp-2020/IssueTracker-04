//
//  UserData.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/13.
//

import Foundation

@propertyWrapper
struct UserInfo {
    private let key: String
 
    var wrappedValue: String {
        get { UserDefaults.standard.string(forKey: key) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
 
    init(key: String) {
        self.key = key
    }
}

@propertyWrapper
struct UserIdentifier {
    private let key: String
 
    var wrappedValue: Int {
        get { UserDefaults.standard.integer(forKey: key) }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
 
    init(key: String) {
        self.key = key
    }
}
 
protocol UserDataProviding {
    var token: String { get set }
    var name: String { get set }
    var image: String { get set }
    var userId: String { get set }
    var usserNo: Int { get set }
}

struct UserData: UserDataProviding {
    @UserInfo(key: "JWT") var token: String
    @UserInfo(key: "UserName") var name: String
    @UserInfo(key: "UserImage") var image: String
    @UserInfo(key: "UserId") var userId: String
    @UserIdentifier(key: "UserNo") var usserNo: Int
}
