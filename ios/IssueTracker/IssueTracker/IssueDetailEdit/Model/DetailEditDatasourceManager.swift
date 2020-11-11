//
//  IssueDetailEditDatasourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import Foundation

class DetailEditDatasourceManager {
    
    enum Section: Int, CaseIterable {
        case selected
        case unSelected
        
        var description: String {
            switch self {
            case .selected:
                return "SELECTED"
            case .unSelected:
                return ""
            }
        }
    }
    
    var networkManager: DetailNetworkManager
    
    init(networkManager: DetailNetworkManager) {
        self.networkManager = networkManager
    }
    
    var selectedItems: [DetailEditCellData] = []
    var unSelectedItems: [DetailEditCellData] = []
    
    subscript(indexPath: IndexPath) -> DetailEditCellData? {
        switch section(of: indexPath) {
        case .selected:
            return selectedItems[indexPath.row]
        case .unSelected:
            return unSelectedItems[indexPath.row]
        case .none:
            return nil
        }
    }
    
    var numberOfSections: Int {
        Section.allCases.count
    }
    
    func section(of indexPath: IndexPath) -> Section? {
        Section(rawValue: indexPath.section)
    }
    
    func headerTitle(of section: Int) -> String? {
        Section(rawValue: section)?.description
    }
    
    func numberOfRow(at section: Int) -> Int {
        switch Section(rawValue: section) {
        case .selected:
            return selectedItems.count
        case .unSelected:
            return unSelectedItems.count
        case .none:
            return 0
        }
    }
    
    func toggle(from indexPath: IndexPath) -> IndexPath? {
        switch section(of: indexPath) {
        case .selected:
            guard let item = self[indexPath],
                  let index = (selectedItems.firstIndex { $0.itemId == item.itemId }) else {
                return nil
            }
            selectedItems.remove(at: index)
            unSelectedItems.insert(item, at: 0)
            return IndexPath(row: 0, section: 1)
            
        case .unSelected:
            guard let item = self[indexPath],
                  let index = (unSelectedItems.firstIndex { $0.itemId == item.itemId }) else {
                return nil
            }
            unSelectedItems.remove(at: index)
            selectedItems.append(item)
            return IndexPath(row: selectedItems.count - 1, section: 0)
        case .none:
            return nil
        }
    }
    
    func loadItems() {
        unSelectedItems = networkManager.loadData()
    }
    
    func updateItems(completion: ((Bool) -> Void)) {
        completion(true)
    }
}
