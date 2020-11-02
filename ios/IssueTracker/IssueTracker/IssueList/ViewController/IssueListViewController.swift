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

    @IBOutlet weak var issueListCollectionView: IssueListCollectionView!
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
    var maximumSafetyAreaInset: CGFloat = 40.0
    
    var mode: Mode = .normal {
        didSet {
            issueListCollectionView.mode = mode
            collectionViewAdapter?.mode = mode
            let editing = mode == .edit
            let leftBarButtonTitle = editing ? "Select All" : "Filter"
            
            leftBarButton.setTitle(leftBarButtonTitle, for: .normal)
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout(viewWidth: size.width)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        issueListCollectionView.deselectAllItems()
        setSelectedIssueCountLabel()
        mode = editing ? .edit : .normal
        issueListCollectionView.changeVisibleCellMode()
        issueListCollectionView.animateVisibleCells()
    }
    
    private func updateLayout(viewWidth: CGFloat) {
        if mode == .normal {
            selectionResultViewLeadingConstraint.constant = -viewWidth
        }
        
        issueListCollectionView.collectionViewLayout.invalidateLayout()
        issueListCollectionView.setVisibleCellWidth(width: viewWidth)
    }
    
    private func configureCollectionView() {
        collectionViewAdapter = IssueListCollectionViewAdapter(dataSourceManager: IssueListDataSourceManager(networkManager: DummyDataLoader()))
        issueListCollectionView.dataSource = collectionViewAdapter
        issueListCollectionView.delegate = self
    }
  
    private func configureCellObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(cellCloseButtonTouched(notification:)), name: .cellCloseButtonDidTouch, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cellDeleteButtonTouched(notification:)), name: .cellDeleteButtonDidTouch, object: nil)
    }
    
    private func addButtonAnimate(showing: Bool) {
        addButtonTrailingConstraint.constant = showing ? addButtonRightConstant : -(addButtonRightConstant + addButton.frame.width + maximumSafetyAreaInset)
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
        selectionResultViewLeadingConstraint.constant = editing ? 0 : -(view.frame.width + maximumSafetyAreaInset)
    }
    
    private func selectResultViewAnimate(editing: Bool) {
        setSelectResultView(editing: editing)
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setSelectedIssueCountLabel() {
        selectedIssueCountLabel.text = String(issueListCollectionView.selectedItemCount)
    }
    
    @objc private func cellDeleteButtonTouched(notification: Notification) {
        guard let issueNo = notification.userInfo?["IssueNo"] as? Int else {
            return
        }
        collectionViewAdapter?.dataSourceManager.deleteIssue(by: issueNo) { [weak self] in
            self?.issueListCollectionView.deleteItems(at: [$0])
        }
    }
    
    @objc private func cellCloseButtonTouched(notification: Notification) {
        guard let issueNo = notification.userInfo?["IssueNo"] as? Int else {
            return
        }
        print("\(issueNo) close")
    }
    
    @IBAction func leftBarButtonTouched(_ sender: UIButton) {
        switch mode {
        case .normal:
            print("Open Filter")
        case .edit:
            if sender.title(for: .normal) == "Select All" {
                sender.setTitle("Deselect All", for: .normal)
                issueListCollectionView.selectAllItems(itemCount: collectionViewAdapter?.dataSourceManager.itemCount ?? 0)
            } else {
                sender.setTitle("Select All", for: .normal)
                issueListCollectionView.deselectAllItems()
            }
            setSelectedIssueCountLabel()
        }
    }
    
    @IBAction func issueCloseButtonTouched(_ sender: UIButton) {
        guard issueListCollectionView.selectedItemCount != 0,
              let selectedIndexPaths = issueListCollectionView.indexPathsForSelectedItems else {
            return
        }
        collectionViewAdapter?.dataSourceManager.closeIssues(indexPaths: selectedIndexPaths)
    }
    
    @IBAction func issueDeleteButtonTouched(_ sender: UIButton) {
        guard issueListCollectionView.selectedItemCount != 0,
              let selectedIndexPaths = issueListCollectionView.indexPathsForSelectedItems else {
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
