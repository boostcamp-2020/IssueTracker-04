//
//  LabelListViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

class LabelListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var adapter: LabelCollectionViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(LabelListCell.self, forCellWithReuseIdentifier: LabelListCell.identifier)
        collectionView.delegate = self
        
        let adapter = LabelCollectionViewAdapter(dataManager: LabelDatasourceManager())
        self.adapter = adapter
        collectionView.dataSource = adapter
    }
}

extension LabelListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}
