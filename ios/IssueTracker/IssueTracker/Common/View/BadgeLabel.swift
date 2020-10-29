//
//  BadgeLabel.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/29.
//

import UIKit

class BadgeLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 2.0
    @IBInspectable var bottomInset: CGFloat = 2.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    @IBInspectable var borderColor: UIColor? {
        get {
            UIColor(cgColor: layer.borderColor ?? CGColor.init(gray: 1, alpha: 1))
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    init(text: String, backgroundColor: UIColor) {
        super.init(frame: CGRect.zero)
        super.text = text
        super.backgroundColor = backgroundColor
        self.borderColor = backgroundColor
        super.font = UIFont.preferredFont(forTextStyle: .caption1)
        super.textColor = .black // 배경 색상에 맞추어 텍스트 색상 변경 필요
        setBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setBorder()
    }
    
    private func setBorder() {
        clipsToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += topInset + bottomInset
        contentSize.width += leftInset + rightInset
        return contentSize
    }
}
