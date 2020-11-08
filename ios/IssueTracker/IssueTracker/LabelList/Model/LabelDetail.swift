//
//  LabelDetail.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import Foundation

struct LabelDetail: Codable, LabelListCellData {
    var label: Label
    var labelDescription: String
}
