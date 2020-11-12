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
        
        NotificationCenter.default.addObserver(self, selector: #selector(labelDeleteButtonTouched(notification:)), name: .labelDeleteRequested, object: nil)
        loadLabels()
    }

    func loadLabels() {
        adapter?.dataManager.load { [weak self] complete in
            DispatchQueue.main.async {
                if complete {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    @objc private func labelDeleteButtonTouched(notification: Notification) {
        guard let labelNo = notification.userInfo?["LabelNo"] as? Int else {
            return
        }
        adapter?.dataManager.delete(with: labelNo) { [weak self] indexPath in
            DispatchQueue.main.async {
                self?.collectionView.deleteItems(at: [indexPath])
                NotificationCenter.default.post(Notification(name: .issueListRefreshRequested))
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "LabelListToAdd",
              let labelAddViewController = segue.destination as? LabelAddViewController else {
            return
        }
        if let indexPath = sender as? IndexPath,
           let adapter = adapter {
            labelAddViewController.indexPath = indexPath
            labelAddViewController.labelData = adapter.dataManager[indexPath]
        }
        labelAddViewController.delegate = self
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
        performSegue(withIdentifier: "LabelListToAdd", sender: indexPath)
    }
    
}

extension LabelListViewController: LabelDataDelegate {
    
    func labelDidAdd(label: Label) {
        adapter?.dataManager.add(label: label) { [weak self] indexPath in
            DispatchQueue.main.async {
                self?.collectionView.performBatchUpdates({
                    self?.collectionView.insertItems(at: [indexPath])
                }, completion: { _ in
                    self?.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                })
            }
        }
    }
    
    func labelDidUpdate(label: Label, indexPath: IndexPath) {
        adapter?.dataManager.update(label: label, indexPath: indexPath) { [weak self] indexPath in
            DispatchQueue.main.async {
                self?.collectionView.reloadItems(at: [indexPath])
            }
        }
    }
}
