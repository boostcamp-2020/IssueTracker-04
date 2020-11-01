//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

class IssueListViewController: UIViewController {
    
    enum Mode {
        case normal
        case edit
    }

    @IBOutlet weak var issueListCollectionView: UICollectionView!
    @IBOutlet weak var addButton: RoundAddButton!
    @IBOutlet weak var leftBarButton: UIButton!
    @IBOutlet weak var selectionResultView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var selectedIssueCountLabel: UILabel!
    
    @IBOutlet weak var selectionResultViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var addButtonTrailingConstraint: NSLayoutConstraint!
    
    var collectionViewAdapter: IssueListCollectionViewAdapter?
    var isOnAddButtonHideAnimation = false
    var isOnAddButtonShowAnimation = false
    var addButtonRightConstant: CGFloat = 20.0
    
    var mode: Mode = .normal {
        didSet {
            collectionViewAdapter?.mode = mode
            let editing = mode == .edit
            let leftBarButtonTitle = editing ? "Select All" : "Filter"
            
            leftBarButton.setTitle(leftBarButtonTitle, for: .normal)
            issueListCollectionView.allowsMultipleSelection = editing
            selectResultViewAnimate(editing: editing)
            addButtonAnimate(showing: !editing)
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCellObserver()
        navigationItem.rightBarButtonItem = editButtonItem
        setSelectResultView(editing: false)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        deselectAllItems()
        setSelectedIssueCountLabel()
        mode = editing ? .edit : .normal
        changeVisibleCellMode()
        issueListCollectionView.animateVisibleCells { cell in
            guard let cell = cell as? LeftContainerContaining else {
                return
            }
            editing ? cell.leftContainerViewShowAnimate() : cell.resetViewAnimate()
        }
    }
    
    private func setupCollectionViewFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        issueListCollectionView.collectionViewLayout = flowLayout
    }
    
    private func configureCollectionView() {
        collectionViewAdapter = IssueListCollectionViewAdapter(dataSourceManager: IssueListDataSourceManager(networkManager: DummyDataLoader()))
        issueListCollectionView.register(UINib(nibName: IssueListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: IssueListCollectionViewCell.identifier)
        issueListCollectionView.dataSource = collectionViewAdapter
        issueListCollectionView.delegate = self
        setupCollectionViewFlowLayout()
    }
    
    private func configureCellObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(closeIssue(notification:)), name: .cellCloseButtonDidTouch, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteIssue(notification:)), name: .cellDeleteButtonDidTouch, object: nil)
    }
    
    @objc func deleteIssue(notification: Notification) {
        guard let issueNo = notification.userInfo?["IssueNo"] else {
            return
        }
        print("\(issueNo) delete")
    }
    
    @objc func closeIssue(notification: Notification) {
        guard let issueNo = notification.userInfo?["IssueNo"] else {
            return
        }
        print("\(issueNo) close")
    }
    
    private func selectAllItems() {
        collectionViewAdapter?.dataSourceManager.items.indices.forEach {
            issueListCollectionView.selectItem(at: IndexPath(row: $0, section: 0), animated: false, scrollPosition: .left)
        }
    }
    
    private func deselectAllItems() {
        issueListCollectionView.indexPathsForSelectedItems?.forEach { issueListCollectionView.deselectItem(at: $0, animated: false)
        }
    }
    
    private func addButtonAnimate(showing: Bool) {
        addButtonTrailingConstraint.constant = showing ? addButtonRightConstant : -(addButtonRightConstant + addButton.frame.width)
        let isOnAnimation = showing ? isOnAddButtonShowAnimation : isOnAddButtonHideAnimation
        
        guard !isOnAnimation else { return }
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) { [weak self] in
            showing ? (self?.isOnAddButtonShowAnimation = true) : (self?.isOnAddButtonHideAnimation = true)
            self?.view.layoutIfNeeded()
        } completion: { [weak self] in
            showing ? (self?.isOnAddButtonShowAnimation = !$0) : (self?.isOnAddButtonHideAnimation = !$0)
        }
    }
    
    private func setSelectResultView(editing: Bool) {
        selectionResultViewLeadingConstraint.constant = editing ? 0 : -searchBar.frame.width
    }
    
    private func selectResultViewAnimate(editing: Bool) {
        setSelectResultView(editing: editing)
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setSelectedIssueCountLabel() {
        selectedIssueCountLabel.text = String(issueListCollectionView.indexPathsForSelectedItems?.count ?? 0)
    }
    
    @IBAction func leftBarButtonTouched(_ sender: UIButton) {
        switch mode {
        case .normal:
            print("Open Filter")
        case .edit:
            if sender.title(for: .normal) == "Select All" {
                sender.setTitle("Deselect All", for: .normal)
                selectAllItems()
            } else {
                sender.setTitle("Select All", for: .normal)
                deselectAllItems()
            }
            setSelectedIssueCountLabel()
        }
    }
    @IBAction func issueCloseButtonTouched(_ sender: UIButton) {
        guard let selectedIndexPaths = issueListCollectionView.indexPathsForSelectedItems, selectedIndexPaths.count != 0 else {
            return
        }
        collectionViewAdapter?.dataSourceManager.closeIssues(indexPaths: selectedIndexPaths)
    }
    
    @IBAction func issueDeleteButtonTouched(_ sender: UIButton) {
        guard let selectedIndexPaths = issueListCollectionView.indexPathsForSelectedItems, selectedIndexPaths.count != 0 else {
            return
        }
        collectionViewAdapter?.dataSourceManager.deleteIssues(indexPaths: selectedIndexPaths)
        issueListCollectionView.performBatchUpdates {
            issueListCollectionView.deleteItems(at: selectedIndexPaths)
        }
        setSelectedIssueCountLabel()
    }
    
}

extension IssueListViewController: UICollectionViewDelegate {
    
    func changeVisibleCellMode() {
        issueListCollectionView.visibleCells.forEach {
            guard let cell =  $0 as? IssueListCollectionViewCell else {
                return
            }
            cell.mode = mode
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if mode == .normal {
            addButtonAnimate(showing: false)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if mode == .normal {
            addButtonAnimate(showing: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mode {
        case .normal:
            print(indexPath)
        case .edit:
            print(indexPath)
            setSelectedIssueCountLabel()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard mode == .edit else {
            return
        }
        setSelectedIssueCountLabel()
    }

}
