//
//  LabelListViewController.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

class LabelListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var adapter: LabelCollectionViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(LabelListCell.self, forCellWithReuseIdentifier: LabelListCell.identifier)
        collectionView.delegate = self
        
        let adapter = LabelCollectionViewAdapter(dataManager: LabelDatasourceManager())
        self.adapter = adapter
        collectionView.dataSource = adapter
        
        NotificationCenter.default.addObserver(self, selector: #selector(labelDeleteButtonTouched(notification:)), name: .labelDeleteButtonDidTouch, object: nil)
    }
    
    private func presentLabelAddView(isUpdate: Bool, indexPath: IndexPath?) {
        guard let labelAddViewController = storyboard?.instantiateViewController(identifier: LabelAddViewController.identifier) as? LabelAddViewController else {
            return
        }
        
        if let indexPath = indexPath,
           let adapter = adapter,
           isUpdate {
            labelAddViewController.indexPath = indexPath
            labelAddViewController.labelData = adapter.dataManager[indexPath]
        }
        
        labelAddViewController.modalPresentationStyle = .pageSheet
        labelAddViewController.modalTransitionStyle = .coverVertical
        labelAddViewController.delegate = self
        present(labelAddViewController, animated: true)
    }
    
    @objc private func labelDeleteButtonTouched(notification: Notification) {
        guard let labelNo = notification.userInfo?["LabelNo"] as? Int else {
            return
        }
        adapter?.dataManager.delete(with: labelNo) { [weak self] indexPath in
            self?.collectionView.deleteItems(at: [indexPath])
        }
    }
    
    @IBAction func addButtonTouched(_ sender: UIBarButtonItem) {
        presentLabelAddView(isUpdate: false, indexPath: nil)
    }
}

extension LabelListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentLabelAddView(isUpdate: true, indexPath: indexPath)
    }
    
}

extension LabelListViewController: LabelDataDelegate {
    func labelDidAdd(label: LabelDetail) {
        adapter?.dataManager.add(label: label) { [weak self] indexPath in
            self?.collectionView.insertItems(at: [indexPath])
            self?.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
    func labelDidUpdate(label: LabelDetail, indexPath: IndexPath) {
        adapter?.dataManager.update(label: label, indexPath: indexPath) { [weak self] indexPath in
            self?.collectionView.reloadItems(at: [indexPath])
        }
    }
}
