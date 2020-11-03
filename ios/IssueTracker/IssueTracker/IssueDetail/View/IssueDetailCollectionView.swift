//
//  IssueDetailCollectionView.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

class IssueDetailCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        register(UINib(nibName: CommentCell.identifier, bundle: nil), forCellWithReuseIdentifier: CommentCell.identifier)
        setFlowLayout()
    }
    
    private func setFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout = flowLayout
    }
}
