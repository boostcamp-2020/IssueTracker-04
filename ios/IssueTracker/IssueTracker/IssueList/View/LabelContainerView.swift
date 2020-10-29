//
//  LabelContainerView.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/29.
//

import UIKit

class LabelContainerView: UIView {
    private let xibName = "LabelContainerView"
    
    @IBOutlet weak var firstLabelStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        guard let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func clear() {
        firstLabelStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func add(labels: [Label]) {
        labels.forEach {
            let badgeLabel = BadgeLabel(text: $0.labelTitle, backgroundColor: UIColor(hexString: $0.labelColor))
            firstLabelStackView.addArrangedSubview(badgeLabel)
        }
    }
}
