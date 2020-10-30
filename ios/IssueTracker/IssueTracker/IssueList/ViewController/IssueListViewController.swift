//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

class IssueListViewController: UIViewController {

    @IBOutlet weak var issueListCollectionView: UICollectionView!
    @IBOutlet weak var addButton: RoundAddButton!
    @IBOutlet weak var addButtonTrailingConstraint: NSLayoutConstraint!
    var collectionViewAdapter: IssueListCollectionViewAdapter?
    
    var isOnAddButtonHideAnimation = false
    var isOnAddButtonShowAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func setupCollectionViewFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        self.issueListCollectionView.collectionViewLayout = flowLayout
    }
    
    private func configureCollectionView() {
        let items = DummyDataLoader().loadIssueItems()
        collectionViewAdapter = IssueListCollectionViewAdapter()
        collectionViewAdapter?.items = items
        issueListCollectionView.register(UINib(nibName: IssueListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: IssueListCollectionViewCell.identifier)
        issueListCollectionView.dataSource = collectionViewAdapter
        issueListCollectionView.delegate = self
        setupCollectionViewFlowLayout()
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.addButtonTrailingConstraint.constant = -62.0
        if !isOnAddButtonHideAnimation {
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.isOnAddButtonHideAnimation = true
                self?.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                self?.isOnAddButtonHideAnimation = false
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.addButtonTrailingConstraint.constant = 20
        if !isOnAddButtonShowAnimation {
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.isOnAddButtonShowAnimation = true
                self?.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                self?.isOnAddButtonShowAnimation = false
            }
        }
    }
}
