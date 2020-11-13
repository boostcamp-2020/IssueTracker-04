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
        addTapToDismissKeyBoard()
        
        collectionViewAdapter?.dataSourceManager.loadIssueList {[weak self] isSuccess in
            guard isSuccess else {
                print("Data Load Fail")
                return
            }
            DispatchQueue.main.async {
                self?.issueListCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { [weak self] _ in
            self?.updateLayout(viewWidth: size.width)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        issueListCollectionView.deselectAllItems()
        setSelectedIssueCountLabel()
        mode = editing ? .edit : .normal
        issueListCollectionView.changeVisibleCellMode()
        issueListCollectionView.animateVisibleCells()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "IssueListToDetail":
            guard let indexPath = sender as? IndexPath,
                  let adpater = collectionViewAdapter,
            let issueDetailViewController = segue.destination as? IssueDetailViewController else {
                return
            }
            let issueNo = adpater.dataSourceManager[indexPath].issueNo
            let issueTitle = adpater.dataSourceManager[indexPath].issueTitle
            
            issueDetailViewController.issueTitle = issueTitle
            issueDetailViewController.issueNo = issueNo
            
            return
        case "ListToIssueAdd":
            guard let issueAddViewController = segue.destination as? IssueAddViewController else {
                return
            }
            issueAddViewController.delegate = self
            return
        default:
            return
        }
    }
    
    private func updateLayout(viewWidth: CGFloat) {
        if mode == .normal {
            selectionResultViewLeadingConstraint.constant = -viewWidth
        }
        let cellWidth = viewWidth - view.safeAreaInsets.left - view.safeAreaInsets.right
        issueListCollectionView.collectionViewLayout.invalidateLayout()
        issueListCollectionView.setVisibleCellWidth(width: cellWidth)
    }
    
    private func configureCollectionView() {
        let networkService = NetworkService()
        let networkManager = IssueListNetworkManager(service: networkService, userData: UserData())
        
        let dataSourceManager = IssueListDataSourceManager(networkManager: networkManager)
        
        collectionViewAdapter = IssueListCollectionViewAdapter(dataSourceManager: dataSourceManager)
        issueListCollectionView.dataSource = collectionViewAdapter
        issueListCollectionView.delegate = self
    }
  
    private func configureCellObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(cellCloseButtonTouched(notification:)), name: .issueCloseRequested, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cellDeleteButtonTouched(notification:)), name: .issueDeleteRequested, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(searchRequested(notification:)), name: .issueListSearchRequested, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .issueListRefreshRequested, object: nil)
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
        collectionViewAdapter?.dataSourceManager.deleteIssue(by: issueNo) { [weak self] index in
            self?.issueListCollectionView.performBatchUpdates {
                self?.issueListCollectionView.deleteItems(at: [index])
            } completion: { _ in
//                let context = UICollectionViewFlowLayoutInvalidationContext()
//                context.invalidateFlowLayoutAttributes = false
//                self?.issueListCollectionView.collectionViewLayout.invalidateLayout(with: context)
//                UIView.animate(withDuration: 0.3) {
//                    self?.issueListCollectionView.layoutIfNeeded()
//                }
            }
        }
    }
    
    @objc private func cellCloseButtonTouched(notification: Notification) {
        guard let issueNo = notification.userInfo?["IssueNo"] as? Int else {
            return
        }
        print("\(issueNo) close")
    }
    
    @objc private func searchRequested(notification: Notification) {
        guard let query = notification.userInfo?["Query"] as? String else {
            return
        }
        searchBar.text = query
    }
    
    @objc private func refresh(notification: Notification) {
        collectionViewAdapter?.dataSourceManager.loadIssueList {[weak self] isSuccess in
            guard isSuccess else {
                return
            }
            DispatchQueue.main.async {
                self?.issueListCollectionView.collectionViewLayout.invalidateLayout()
                self?.issueListCollectionView.reloadSections([0])
            }
        }
    }
    
    @IBAction func leftBarButtonTouched(_ sender: UIButton) {
        switch mode {
        case .normal:
            performSegue(withIdentifier: "IssueListToFilter", sender: nil)
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

extension IssueListViewController: IssueAddViewControllerDelegate {
    
    func issueSendButtonDidTouch(request: IssueAddRequest) {
        collectionViewAdapter?.dataSourceManager.add(issue: request) { [weak self] complete in
            if complete {
                DispatchQueue.main.async {
                    self?.issueListCollectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
                }
            }
        }
    }
    
}

extension IssueListViewController: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
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
            performSegue(withIdentifier: "IssueListToDetail", sender: indexPath) // send selectedIssue ID
        case .edit:
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
