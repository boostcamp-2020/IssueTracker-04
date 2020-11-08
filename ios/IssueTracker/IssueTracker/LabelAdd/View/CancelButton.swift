//
//  CancelButton.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

@IBDesignable
class CancelButton: UIButton {
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let widthOffset = rect.size.width/4
        let heightOffset = rect.size.width/4
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: center.x - widthOffset, y: center.y - heightOffset))
        path.addLine(to: CGPoint(x: center.x + widthOffset, y: center.y + heightOffset))
        
        path.move(to: CGPoint(x: center.x + widthOffset, y: center.y - heightOffset))
        path.addLine(to: CGPoint(x: center.x - widthOffset, y: center.y + heightOffset))
        path.close()
        
        UIColor.darkGray.set()
        path.lineWidth = 2.5
        path.stroke()
    }
}
