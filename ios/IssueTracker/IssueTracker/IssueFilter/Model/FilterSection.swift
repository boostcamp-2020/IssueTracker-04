//
//  FilterSection.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

enum FilterSection: Int, CaseIterable {
    case defaultOption
    case detailOption
    
    var description: String {
        switch self {
        case .defaultOption:
            return "다음 중에 조건을 고르세요"
        case .detailOption:
            return "세부 조건"
        }
    }
}
