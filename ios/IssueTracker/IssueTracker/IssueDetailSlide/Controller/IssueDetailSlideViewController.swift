//
//  IssueDetailSlideViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/05.
//

import UIKit

protocol IssueDetailSlideViewControllerDelegate: class {
    func didIssueButtonTouched(flag: Bool)
    func didAddCommentButtonTouched()
}

class IssueDetailSlideViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: IssueDetailSlideViewControllerDelegate?
    
    var adapter: IssueSlideVIewCollectionViewAdapter? {
        didSet {
            collectionView.dataSource = adapter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNotification()
        configureLayer()
        configureCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editViewController = segue.destination as? IssueDetailEditViewController,
              let adapter = adapter else {
            return
        }
        let selectedItems: [DetailEditCellData]
        let networkManager: DetailNetworkManager
        let networkService = NetworkService()
        switch segue.identifier {
        case "ToEditAssignee":
            editViewController.mode = .assignee
            networkManager = AssigneeEditNetworkManager(service: networkService)
            selectedItems = adapter.dataManager.assignees.map { DetailEditCellData(type: .assignee(image: $0.userImg), itemId: $0.userNo, title: $0.userName) }
        case "ToEditLabel":
            editViewController.mode = .label
            networkManager = LabelEditNetworkManager(service: networkService)
            selectedItems = adapter.dataManager.labels.map { DetailEditCellData(type: .label(color: $0.labelColor), itemId: $0.labelNo, title: $0.labelTitle) }
        case "ToEditMilestone":
            editViewController.mode = .milestone
            networkManager = MilestoneEditNetworkManager(service: networkService)
            let milestone = adapter.dataManager.milestone
            selectedItems = [DetailEditCellData(type: .milestone, itemId: milestone.milestoneNo, title: milestone.milestoneTitle)]
        default:
            return
        }
        let dataManager = DetailEditDatasourceManager(networkManager: networkManager)
        dataManager.selectedItems = selectedItems
        editViewController.delegate = self
        editViewController.dataManager = dataManager
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(editButtonTouched(_:)),
                                               name: .editButtonTouched,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closedButtonTouched(_:)),
                                               name: .closedButtonTouched,
                                               object: nil)
    }
    
    private func configureLayer() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        
        collectionView.registerHeader(identifier: IssueDetailSlideViewHeader.identifier)
        collectionView.registerCell(identifier: AssigneeCollectionViewCell.identifier)
        collectionView.registerCell(identifier: LabelCollectionViewCell.identifier)
        collectionView.registerCell(identifier: MileStoneCollectionViewCell.identifier)
        collectionView.registerCell(identifier: ClosedCollectionViewCell.identifier)
        collectionView.registerHeader(identifier: "EmptyDetailSlideViewHeader")
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    @objc func editButtonTouched(_ notification: Notification) {
        guard let section = notification.userInfo?["section"] as? Int else {
            return
        }
        switch IssueSlideViewDataSourceManager.Section(rawValue: section) {
        case .assignee:
            performSegue(withIdentifier: "ToEditAssignee", sender: nil)
        case .label:
            performSegue(withIdentifier: "ToEditLabel", sender: nil)
        case .milestone:
            performSegue(withIdentifier: "ToEditMilestone", sender: nil)
        default:
            return
        }
    }
    
    @objc func closedButtonTouched(_ notification: Notification) {
        if let flag = adapter?.dataManager.issueFlag {
            adapter?.dataManager.issueFlag = !flag
            delegate?.didIssueButtonTouched(flag: !flag)
        }
    }
    
    @IBAction func addCommentButtonTouched(_ sender: Any) {
        delegate?.didAddCommentButtonTouched()
    }
    
}

extension IssueDetailSlideViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 58)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let adapter = adapter else {
            return .zero
        }
        
        switch adapter.dataManager.section(of: indexPath) {
        case .assignee:
            return CGSize(width: collectionView.frame.width - 32, height: 48)
        case .label:
            let width = adapter.dataManager.labelTitle(of: indexPath).estimatedLabelWidth(height: 30, fontSize: 17)
            return CGSize(width: width + 12, height: 30)
        case .milestone:
            return CGSize(width: collectionView.frame.width - 32, height: 120)
        case .option:
            return CGSize(width: collectionView.frame.width - 32, height: 64)
        case.none:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

extension IssueDetailSlideViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        collectionView.contentOffset.y <= 0
    }
}

extension IssueDetailSlideViewController: IssueDetailEditDelegate {
    func itemDidUpdate(items: [DetailEditCellData], mode: IssueDetailEditViewController.Mode) {
        switch mode {
        case .assignee:
            adapter?.dataManager.assignees = items.map { Assignee(userNo: $0.itemId, userName: $0.title, userImg: $0.rawData) }
        case .label:
            adapter?.dataManager.labels = items.map { Label(labelNo: $0.itemId, labelTitle: $0.title, labelColor: $0.rawData) }
        case .milestone:
            adapter?.dataManager.milestone = Milestone(milestoneNo: items[0].itemId, milestoneTitle: items[0].title)
        }
        collectionView.reloadSections([mode.rawValue])
    }
}
