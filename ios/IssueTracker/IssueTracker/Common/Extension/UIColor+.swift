//
//  UIColor+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/29.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        var hex = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt64 = 10066329
        
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        if hex.count == 6 {
            Scanner(string: hex).scanHexInt64(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1
        )
    }
    
    var visibleTextColor: UIColor {
        let ciColor = CIColor(color: self)
        let red = ciColor.red
        let green = ciColor.green
        let blue = ciColor.blue
        
        let yiq = ((red * 299) + (green * 587) + (blue * 114))/1000
        
        return yiq >= 128/255 ? UIColor.black : UIColor.white
    }
}
