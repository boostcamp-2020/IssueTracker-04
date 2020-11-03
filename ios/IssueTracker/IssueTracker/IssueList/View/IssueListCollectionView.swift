//
//  IssueListCollectionView.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/01.
//

import UIKit

class IssueListCollectionView: UICollectionView {
    
    var mode: IssueListViewController.Mode = .normal {
        didSet {
            allowsMultipleSelection = mode == .edit
        }
    }
    
    var selectedItemCount: Int {
        indexPathsForSelectedItems?.count ?? 0
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        register(UINib(nibName: IssueListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: IssueListCollectionViewCell.identifier)
        setupCollectionViewFlowLayout()
    }
    
    private func setupCollectionViewFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout = flowLayout
    }
    
    func changeVisibleCellMode() {
        visibleCells.forEach {
            guard let cell =  $0 as? IssueListCollectionViewCell else {
                return
            }
            cell.mode = mode
        }
    }
    
    func setVisibleCellWidth(width: CGFloat) {
        visibleCells.forEach {
            guard let cell = $0 as? IssueListCollectionViewCell else {
                return
            }
            cell.cellMainWidth = width
            switch mode {
            case .edit:
                cell.showLeftContainerView()
            case .normal:
                cell.showMainView()
            }
        }
    }
    
    func animateVisibleCells() {
        visibleCells.forEach { cell in
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) { [weak self] in
                guard let cell = cell as? LeftContainerContaining else {
                    return
                }
                self?.mode == .edit ? cell.leftContainerViewShowAnimate() : cell.resetViewAnimate()
            }
        }
    }
    
    func selectAllItems(itemCount: Int) {
        (0..<itemCount).forEach {
            selectItem(at: IndexPath(row: $0, section: 0), animated: false, scrollPosition: .left)
        }
    }
    
    func deselectAllItems() {
        indexPathsForSelectedItems?.forEach {
            deselectItem(at: $0, animated: false)
        }
    }
}
