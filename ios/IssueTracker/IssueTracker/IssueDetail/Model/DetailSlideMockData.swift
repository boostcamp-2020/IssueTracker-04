//
//  DetailSlideMockData.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/03.
//

import Foundation

struct DetailSlideMockData {
    
    private(set) var assignees: [Assignee] = []
    private(set) var labels: [Label] = []
    private(set) var mileStone: [MileStone] = []
    
    init() {
        assignees.append(Assignee(iuRelationNo: 0, userNo: 0, userID: "Oh Donggeon", userImg: "asdfasdf"))
        assignees.append(Assignee(iuRelationNo: 0, userNo: 0, userID: "Oh Donggeon", userImg: "asdfasdf"))
        assignees.append(Assignee(iuRelationNo: 0, userNo: 0, userID: "Oh Donggeon", userImg: "asdfasdf"))
        
        labels.append(Label(ilRelationNo: 0, labelNo: 0, labelTitle: "라벨1", labelColor: "#AAAAAA"))
        labels.append(Label(ilRelationNo: 0, labelNo: 0, labelTitle: "라벨222", labelColor: "#AAAAAA"))
        labels.append(Label(ilRelationNo: 0, labelNo: 0, labelTitle: "라벨3333333", labelColor: "#AAAAAA"))
        labels.append(Label(ilRelationNo: 0, labelNo: 0, labelTitle: "라4", labelColor: "#AAAAAA"))
        labels.append(Label(ilRelationNo: 0, labelNo: 0, labelTitle: "라", labelColor: "#AAAAAA"))
        labels.append(Label(ilRelationNo: 0, labelNo: 0, labelTitle: "ㄹ", labelColor: "#AAAAAA"))
        labels.append(Label(ilRelationNo: 0, labelNo: 0, labelTitle: "라벨임", labelColor: "#AAAAAA"))
        
        mileStone.append(MileStone(milestoneID: "ID", milestoneTitle: "스프린트 1", milestoneDesc: "몰라", dueDate: Date()))
    }
    
}
