//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/28.
//

import UIKit

class IssueListViewController: UIViewController {

    @IBOutlet weak var issueListCollectionView: UICollectionView!
    
    var collectionViewAdapter: IssueListCollectionViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func setupCollectionViewFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 1
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: width, height: width/3.5)

        self.issueListCollectionView.collectionViewLayout = flowLayout
    }
    
    private func configureCollectionView() {
        let items = DummyDataLoader().loadIssueItems()
        collectionViewAdapter = IssueListCollectionViewAdapter()
        collectionViewAdapter?.items = items
        issueListCollectionView.register(UINib(nibName: IssueListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: IssueListCollectionViewCell.identifier)
        issueListCollectionView.dataSource = collectionViewAdapter
        issueListCollectionView.delegate = collectionViewAdapter
        setupCollectionViewFlowLayout()
    }
}
