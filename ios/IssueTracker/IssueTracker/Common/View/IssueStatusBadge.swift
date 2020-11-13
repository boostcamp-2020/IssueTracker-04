//
//  IssueStatusBadge.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/13.
//

import UIKit

@IBDesignable
class IssueStatusBadge: UIButton {
    
    var openImage = UIImage(systemName: "exclamationmark.circle")
    var openBackgrondColor = UIColor(named: "OpenBadgeBackground")
    var openTintColor = UIColor(named: "OpenBadgeTint")
    
    var closeImage = UIImage(systemName: "exclamationmark.triangle")
    var closeBackgrondColor = UIColor(named: "CloseBadgeBackground")
    var closeTintColor = UIColor(named: "CloseBadgeTint")
    
    var isOpen: Bool = true {
        didSet {
            let image = isOpen ? openImage : closeImage
            let tint = isOpen ? openTintColor : closeTintColor
            let background = isOpen ? openBackgrondColor : closeBackgrondColor
            let title = isOpen ? "Open" : "Closed"
            setImage(image, for: .normal)
            backgroundColor = background
            setTitleColor(tint, for: .normal)
            tintColor = tint
            setTitle(title, for: .normal)
        }
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
        isUserInteractionEnabled = false
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        setImage(openImage, for: .normal)
        backgroundColor = openBackgrondColor
        setTitle("Open", for: .normal)
        setTitleColor(openTintColor, for: .normal)
        tintColor = openTintColor
        
        clipsToBounds = true
        layer.cornerRadius = 5.0
    }
}
