//
//  IssueListFilterViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/10.
//

import UIKit

class IssueFilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataManager = IssueFilterDatasourceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func doneButtonTouched(_ sender: UIButton) {
        NotificationCenter.default.post(Notification(name: .searchRequested, object: nil, userInfo: ["Query": dataManager.searchQuery]))
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonTouched(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension IssueFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataManager[indexPath]
        item.isSelected = true
        switch dataManager.section(of: indexPath) {
        case .defaultOption:
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        case .detailOption:
            switch item.type {
            case .option(let selectedType):
                let appendedIndexPaths = dataManager.showSubItems(of: selectedType)
                tableView.insertRows(at: appendedIndexPaths, with: .automatic)
            default:
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        case .none:
            return
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let item = dataManager[indexPath]
        item.isSelected = false
        switch dataManager.section(of: indexPath) {
        case .defaultOption:
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        case .detailOption:
            switch item.type {
            case .option(let selectedType):
                let deletedIndexPaths = dataManager.hideSubItems(of: selectedType)
                tableView.deleteRows(at: deletedIndexPaths, with: .automatic)
            default:
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        case .none:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        36
    }
}

extension IssueFilterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        FilterSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataManager.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FilterSection(rawValue: section)?.description ?? ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = dataManager[indexPath]
        let isSelected = item.isSelected
        if isSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
        
        var returnCell: UITableViewCell
        
        switch item.type {
        case .option:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = item.title
            returnCell = cell
        case .author(let image), .assignee(let image):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = item.title
            returnCell = cell
        case .label(let color):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell") as? BadgeTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: item.title, color: color)
            returnCell = cell
        case .milestone:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell") as? BadgeTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: item.title)
            returnCell = cell
        }
        returnCell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        returnCell.accessoryType = isSelected ? .checkmark : .none
        
        return returnCell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .systemGray6
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.font = UIFont.systemFont(ofSize: 13)
        header.textLabel?.textColor = .systemGray
        header.textLabel?.frame.origin = CGPoint(x: 0, y: 15)
        header.textLabel?.bounds.origin = CGPoint(x: 0, y: 15)
    }
}
