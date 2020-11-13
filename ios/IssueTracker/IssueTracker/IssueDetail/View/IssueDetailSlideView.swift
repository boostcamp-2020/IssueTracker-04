//
//  IssueDetailSlideView.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

@IBDesignable
class IssueDetailSlideView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    private var xibName: String {
        String(describing: Self.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
        clipsToBounds = true
        layer.cornerRadius = 20
        
        collectionView.register(UINib(nibName: "IssueDetailSlideViewHeader", bundle: nil), forCellWithReuseIdentifier: "IssueDetailSlideViewHeader")
        collectionView.register(UINib(nibName: "AssigneeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AssigneeCollectionViewCell")
        collectionView.register(UINib(nibName: "LabelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LabelCollectionViewCell")
        collectionView.register(UINib(nibName: "MileStoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MileStoneCollectionViewCell")
        collectionView.register(UINib(nibName: "EmptyDetailSlideViewHeader", bundle: nil), forCellWithReuseIdentifier: "EmptyDetailSlideViewHeader")
    }
}
