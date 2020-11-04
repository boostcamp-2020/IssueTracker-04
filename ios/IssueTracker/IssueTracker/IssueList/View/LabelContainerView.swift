//
//  LabelContainerView.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/10/29.
//

import UIKit

class LabelContainerView: UIView {
    private var xibName: String {
        String(describing: Self.self)
    }

    @IBOutlet weak var labelsStackView: UIStackView!
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
    }
    
    func add(labels: [Label]) {
        var currentWidth: CGFloat = 0
        addStackView()
        labels.forEach {
            let badgeLabel = BadgeLabel(text: $0.labelTitle, backgroundColor: UIColor(hexString: $0.labelColor))
            if currentWidth + badgeLabel.estimatedSize < maxWidth {
                labelStackViews.last?.addArrangedSubview(badgeLabel)
                currentWidth += badgeLabel.estimatedSize + self.stackViewSpacing
            } else {
                addStackView()
                labelStackViews.last?.addArrangedSubview(badgeLabel)
                currentWidth = badgeLabel.estimatedSize + self.stackViewSpacing
            }
        }
    }
    
    func clear() {
        labelsStackView.subviews.forEach { stackView in
            stackView.subviews.forEach { $0.removeFromSuperview() }
            stackView.removeFromSuperview()
        }
        labelStackViews = []
    }
    
    private func addStackView() {
        let newStackView = UIStackView()
        newStackView.spacing = stackViewSpacing
        labelsStackView.addArrangedSubview(newStackView)
        labelStackViews.append(newStackView)
    }
}
