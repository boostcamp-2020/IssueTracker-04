//
//  SwipableCollectionViewCell.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

@IBDesignable
class SwipableCollectionViewCell: UICollectionViewCell {
    
    var mainLeadingConstraint: NSLayoutConstraint?
    var rightContainerViewWidthConstraint: NSLayoutConstraint?
    var mainView: UIView?
    var rightContainerView: UIView?
    var panGesture: UIPanGestureRecognizer?
    var rightContentWidth: CGFloat = 80.0
    var maximumSwipeWidth: CGFloat {
        //rightContentWidth * 2
        contentView.frame.width * 0.6
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        contentView.backgroundColor = .systemRed
        configureMainView()
        configureContainerView()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onGesture))
        panGesture.cancelsTouchesInView = true
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
        self.panGesture = panGesture
    }
    
    private func configureMainView() {
        let mainView = UIView()
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainLeadingConstraint = mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        let constraints = [
            mainLeadingConstraint ?? NSLayoutConstraint(),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        mainView.backgroundColor = .systemBackground
        self.mainView = mainView
    }
    
    private func configureContainerView() {
        let containerView = UIView()
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        rightContainerViewWidthConstraint = containerView.widthAnchor.constraint(equalToConstant: rightContentWidth)
        let constraints = [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: mainView?.trailingAnchor ?? NSLayoutXAxisAnchor()),
            rightContainerViewWidthConstraint ?? NSLayoutConstraint(),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
        containerView.backgroundColor = .systemRed
        self.rightContainerView = containerView
    }
    
    @objc func onGesture() {
        guard let gesture = panGesture,
              let leadingAnchor = mainLeadingConstraint else {
            return
        }
        if gesture.state == .ended {
       
            let velocity = gesture.velocity(in: mainView).x
            gestureDidFinish(velocity: velocity)
            gesture.setTranslation(.zero, in: mainView)
            return
        }
        
        var newConstant = leadingAnchor.constant + gesture.translation(in: mainView).x
        
        switch newConstant {
        case (-maximumSwipeWidth...0):
            leadingAnchor.constant = newConstant
            panGesture?.setTranslation(.zero, in: mainView)
            
        case _ where newConstant > 0:
            newConstant = 0
            leadingAnchor.constant = newConstant
            panGesture?.setTranslation(.zero, in: mainView)
        
        case _ where newConstant < -maximumSwipeWidth:
            if gesture.translation(in: mainView).x > 0 {
                newConstant = -maximumSwipeWidth
                leadingAnchor.constant = newConstant
                rightContainerViewWidthConstraint?.constant = rightContentWidth
            } else {
                if -newConstant > contentView.frame.width {
                    panGesture?.setTranslation(.zero, in: mainView)
                    return
                }
                newConstant = -contentView.frame.width
                leadingAnchor.constant = newConstant
                rightContainerViewWidthConstraint?.constant = contentView.frame.width
            }
            
            panGesture?.setTranslation(.zero, in: mainView)
            UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve) { [weak self] in
                self?.layoutIfNeeded()
            }
        
        default:
            return
        }
    }
    
    private func gestureDidFinish(velocity: CGFloat) {
        guard let leadingAnchor = mainLeadingConstraint else {
            return
        }
        
        if abs(leadingAnchor.constant) > maximumSwipeWidth && velocity < 0 {
            didFullSwipe()
        }
        
        let newConstant: CGFloat = (velocity > 0 && abs(leadingAnchor.constant) < contentView.frame.width/2) ? 0.0 : -rightContentWidth
        
        leadingAnchor.constant = newConstant
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func didFullSwipe() {
        
    }
    
}

extension SwipableCollectionViewCell: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gesture = panGesture else {
            return false
        }
        return abs((gesture.velocity(in: gestureRecognizer.view)).x) > abs((gesture.velocity(in: gestureRecognizer.view)).y)
    }
}
