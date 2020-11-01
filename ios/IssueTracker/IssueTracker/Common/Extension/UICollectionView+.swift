//
//  UICollectionView+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/01.
//

import UIKit

extension UICollectionView {
    func animateVisibleCells(animation: @escaping (UICollectionViewCell) -> Void) {
        visibleCells.forEach { cell in
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                animation(cell)
            }
        }
    }
}
