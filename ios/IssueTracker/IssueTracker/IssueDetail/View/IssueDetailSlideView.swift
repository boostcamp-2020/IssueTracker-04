//
//  IssueDetailSlideView.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

protocol IssueDetailSlideViewDelegate {
    
}

@IBDesignable
class IssueDetailSlideView: UIView {

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
    }
    
}
