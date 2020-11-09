//
//  BadgeLabel.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/29.
//

import UIKit

@IBDesignable
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
    
    private var estimaedTextSize: CGFloat = 10.5
    
    var estimatedSize: CGFloat {
        guard let text = text else {
            return leftInset + rightInset
        }
        return (CGFloat(text.count) * estimaedTextSize) + leftInset + rightInset
    }

    init(text: String, backgroundColor: UIColor) {
        super.init(frame: CGRect.zero)
        configure(text: text, backgroundColor: backgroundColor)
        self.font = UIFont.preferredFont(forTextStyle: .caption1)
        setBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setBorder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBorder()
    }
    
    private func setBorder() {
        clipsToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
    
    private func configure(text: String, backgroundColor: UIColor) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.borderColor = backgroundColor
        self.textColor = backgroundColor.visibleTextColor
    }
    
    func configure(with label: Label) {
        configure(text: label.labelTitle, backgroundColor: UIColor(hexString: label.labelColor))
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
