//
//  DummyDataLoader.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

protocol NetworkManaging {
    func loadItems() -> [IssueItem]
}

struct DummyDataLoader: NetworkManaging {
    
    func loadItems() -> [IssueItem] {
        
        guard let dataAsset = NSDataAsset.init(name: "dummyIssueList") else {
            return []
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        var items = [IssueItem]()
        do {
            items = try decoder.decode([IssueItem].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        return items
    }
    
    func loadDetail() -> IssueDetail? {
        guard let dataAsset = NSDataAsset.init(name: "dummyIssueDetail") else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        var item: IssueDetail?
        do {
            item = try decoder.decode(IssueDetail.self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        return item
    }
}
