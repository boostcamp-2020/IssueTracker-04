//
//  IssueDetailEditViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/11.
//

import UIKit

protocol IssueDetailEditDelegate: class {
    func itemDidUpdate(items: [DetailEditCellData], mode: IssueDetailEditViewController.Mode)
}

class IssueDetailEditViewController: UIViewController {

    enum Mode: Int {
        case assignee
        case label
        case milestone
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editTableView: UITableView!
    
    var mode: Mode = .assignee
    
    var dataManager: DetailEditDatasourceManager?
    weak var delegate: IssueDetailEditDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTableView.delegate = self
        editTableView.dataSource = self
        switch mode {
        case .assignee:
            titleLabel.text = "담당자 편집"
        case .label:
            titleLabel.text = "레이블 편집"
        case .milestone:
            titleLabel.text = "마일스톤 편집"
        }
        dataManager?.loadItems { [weak self] isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.editTableView?.reloadData()
                }
            }
        }
    }
    
    @IBAction func cancelButtonDidTouch(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButtonDidTouch(_ sender: UIButton) {
        dataManager?.updateItems { isSuccess in
            guard isSuccess else {
                return
            }
            delegate?.itemDidUpdate(items: dataManager?.selectedItems ?? [], mode: mode)
            dismiss(animated: true)
        }
    }
}

extension IssueDetailEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = dataManager?.toggle(from: indexPath) else {
            return
        }
        tableView.moveRow(at: indexPath, to: destination)
        (tableView.cellForRow(at: destination)?.accessoryView as? UIImageView)?.image = destination.section == 0 ? .remove : .add
        if mode == .milestone && indexPath.section == 1 && destination.row != 0 {
            selectRow(at: IndexPath(row: 0, section: 0))
        }
    }
    
    private func selectRow(at indexPath: IndexPath) {
        tableView(editTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
}

extension IssueDetailEditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataManager?.numberOfRow(at: section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataManager?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = dataManager?[indexPath] else {
            return UITableViewCell()
        }
        
        switch item.type {
        case .assignee(let image):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AssigneeCell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = item.title
            cell.accessoryView = indexPath.section == 0 ? UIImageView(image: UIImage.remove) : UIImageView(image: UIImage.add)
            return cell
        case .label(let color):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell") as? BadgeTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: item.title, color: color)
            cell.accessoryView = indexPath.section == 0 ? UIImageView(image: UIImage.remove) : UIImageView(image: UIImage.add)
            return cell
        case .milestone:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell") as? BadgeTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: item.title)
            cell.accessoryView = indexPath.section == 0 ? UIImageView(image: UIImage.remove) : UIImageView(image: UIImage.add)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataManager?.headerTitle(of: section)
    }
}
