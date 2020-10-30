//
//  RoundAddButton.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/30.
//

import UIKit

class RoundAddButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateLayerProperties()
    }

    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let offset = rect.width * 0.5 / 2
        
        let circlePath = UIBezierPath(ovalIn: rect)
        UIColor.systemBlue.set()
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
    
    func updateLayerProperties() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 6)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
    }
}
