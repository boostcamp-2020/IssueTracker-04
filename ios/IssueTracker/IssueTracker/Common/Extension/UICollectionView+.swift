//
//  UICollectionView+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/06.
//

import UIKit

extension UICollectionView {
    
    func registerCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func registerHeader(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }
}
