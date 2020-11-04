//
//  CommentItem.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import Foundation

struct CommentItem: Codable, CommentCellData {
    var commentNo: Int
    var comment: String
    var authorNo: Int
    var authorImg: String
    var commentDate: Date
}
