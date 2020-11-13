//
//  RoundAddButton.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/30.
//

import UIKit

@IBDesignable
class RoundAddButton: UIButton {
    
    @IBInspectable
    var buttonColor: UIColor?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
 
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let offset = rect.width * 0.5 / 2
        
        let circlePath = UIBezierPath(ovalIn: rect)
        (buttonColor ?? UIColor.systemBlue).set()
        circlePath.fill()
        
        let plusPath = UIBezierPath()
        plusPath.move(to: CGPoint(x: center.x - offset, y: center.y))
        plusPath.addLine(to: CGPoint(x: center.x + offset, y: center.y))
        
        plusPath.move(to: CGPoint(x: center.x, y: center.y - offset))
        plusPath.addLine(to: CGPoint(x: center.x, y: center.y + offset))
        plusPath.close()
        
        UIColor.white.set()
        plusPath.lineWidth = 4
        plusPath.stroke()
    }
    
    func configureShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        layer.shadowOffset = CGSize(width: 2, height: 6)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width).cgPath
        layer.masksToBounds = false
    }
}
