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
        decoder.dateDecodingStrategy = .formatted(DateFormatter.custom)
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
    
    func loadMilestones() -> [MilestoneDetail] {
        guard let dataAsset = NSDataAsset.init(name: "dummyMilestones") else {
            return []
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        var items: [MilestoneDetail] = []
        do {
            items = try decoder.decode([MilestoneDetail].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        return items
    }
    
    func loadLabels() -> [LabelDetail] {
        guard let dataAsset = NSDataAsset.init(name: "dummyLabels") else {
            return []
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        var items: [LabelDetail] = []
        do {
            items = try decoder.decode([LabelDetail].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        return items
    }
    
}

extension DateFormatter {
    static let custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.calendar = Calendar(identifier: .iso8601)
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
      }()
}
