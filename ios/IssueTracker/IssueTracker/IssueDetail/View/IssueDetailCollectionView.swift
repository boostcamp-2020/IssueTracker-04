//
//  IssueDetailCollectionView.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

class IssueDetailCollectionView: UICollectionView {
    
    private let headerTitleFontSize: CGFloat = 24.0
    private let headerBaseHeight: CGFloat = 116.0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        registerCell(identifier: CommentCell.identifier)
        registerHeader(identifier: IssueDetailCollectionViewHeader.identifier)
        setFlowLayout()
    }
    
    private func setFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.sectionInset = UIEdgeInsets(top: 20.0, left: 0, bottom: 0, right: 0)
        collectionViewLayout = flowLayout
    }
    
    func setHeaderSize(with titleText: String, width: CGFloat) {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        let height = titleText.estimatedLabelHeight(width: width, fontSize: headerTitleFontSize)
        flowLayout.headerReferenceSize = CGSize(width: width, height: headerBaseHeight + height)
    }
}
