//
//  ColorBox.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

@IBDesignable
class ColorBox: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        clipsToBounds = true
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    func configure(with hexString: String) {
        let color = UIColor(hexString: hexString)
        backgroundColor = color
        layer.borderColor = color.luma > 230/255 ? UIColor.black.cgColor : color.cgColor
    }
}
