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
    var labelStackViews: [UIStackView] = []
    var labelRows: Int {
        labelStackViews.count
    }
    
    var maxWidth: CGFloat = 0.0
    var stackViewSpacing: CGFloat = 5.0
    
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
        labelStackViews.append(firstLabelStackView)
    }
    
    func add(labels: [Label]) {
        var currentWidth: CGFloat = 0
        
        labels.forEach {
            let badgeLabel = BadgeLabel(text: $0.labelTitle, backgroundColor: UIColor(hexString: $0.labelColor))
            if currentWidth + badgeLabel.estimatedSize < maxWidth {
                labelStackViews.last?.addArrangedSubview(badgeLabel)
                currentWidth += badgeLabel.estimatedSize + self.stackViewSpacing
            } else {
                let newStackView = addStackView()
                newStackView.addArrangedSubview(badgeLabel)
                currentWidth = badgeLabel.estimatedSize + self.stackViewSpacing
            }
        }
    }
    
    private func addStackView() -> UIStackView {
        let newStackView = UIStackView()
        newStackView.spacing = stackViewSpacing
        self.addSubview(newStackView)
        newStackView.translatesAutoresizingMaskIntoConstraints = false
        newStackView.topAnchor.constraint(equalTo: labelStackViews.last?.bottomAnchor ?? self.topAnchor, constant: 5).isActive = true
        newStackView.leadingAnchor.constraint(equalTo: labelStackViews.last?.leadingAnchor ?? self.leadingAnchor).isActive = true
        labelStackViews.append(newStackView)
        
        return newStackView
    }
}
