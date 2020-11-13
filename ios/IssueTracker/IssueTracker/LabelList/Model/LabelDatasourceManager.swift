//
//  LabelDatasourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import Foundation

class LabelDatasourceManager {
    
    var items: [Label] = []
    var itemCount: Int {
        items.count
    }
    
    private var networkManager: LabelListNetworkManager
    
    subscript(indexPath: IndexPath) -> Label {
        items[indexPath.row]
    }
    
    init(networkManager: LabelListNetworkManager) {
        self.networkManager = networkManager
    }
    
    func load(complete: @escaping (Bool) -> Void) {
        networkManager.loadLabelList { [weak self] result in
            switch result {
            case .success(let labels):
                self?.items.append(contentsOf: labels)
                complete(true)
            case .failure:
                complete(false)
            }
        }
    }
    
    func add(label: Label, completion: @escaping ((IndexPath) -> Void)) {
        var label = label
        networkManager.add(label: label) { [weak self] result in
            switch result {
            case .success(let status):
                label.labelNo = status.labelNo
                self?.items.append(label)
                guard let row = self?.items.count else {
                    return
                }
                completion(IndexPath(row: row - 1, section: 0))
            case .failure:
                return
            }
        }
    }
    
    func update(label: Label, indexPath: IndexPath, completion: @escaping ((IndexPath) -> Void)) {
        networkManager.update(label: label) { [weak self] result in
            switch result {
            case .success:
                guard label.labelNo == self?[indexPath].labelNo else {
                    return
                }
                self?.items[indexPath.row] = label
                completion(indexPath)
            case .failure:
                return
            }
        }
    }

    func delete(with labelNo: Int, completion: @escaping ((IndexPath) -> Void)) {
        networkManager.delete(labelNo: labelNo) { [weak self] result in
            switch result {
            case .success:
                guard let index = (self?.items.firstIndex { $0.labelNo == labelNo }) else {
                    return
                }
                self?.items.remove(at: index)
                completion(IndexPath(row: index, section: 0))
            case .failure:
                return
            }
        }
    }
}
