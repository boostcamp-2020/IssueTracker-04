//
//  RandomButton.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

@IBDesignable
class RandomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setImage(UIImage(systemName: "arrow.clockwise", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)), for: .normal)
        tintColor = .black
        backgroundColor = .systemGray3
        clipsToBounds = true
        layer.cornerRadius = frame.width/2
        titleLabel?.removeFromSuperview()
        contentMode = .center
        imageView?.contentMode = .scaleAspectFit
    }
}
