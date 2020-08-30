//
//  ViewController.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 24.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    private var viewModel = MainViewModel()
    private var dataSource: MainViewDataSource!
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
        collectionFlowLayout()
        dataSource = MainViewDataSource(viewModel: viewModel)
        collectionView.dataSource = dataSource
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    // MARK: - Fetching Items
    func fetchItems() {
        viewModel.fetchItems(text: "Solomun", limit: 10, completion: {
            self.collectionView.reloadData()
        })
    }
    // MARK: - UI Functions
    func collectionFlowLayout() {
        let flowLayout = CollectionViewFlowLayout()
        flowLayout.flowDelegate = self
        self.collectionView.collectionViewLayout = flowLayout
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let flowLayout = self.collectionView.collectionViewLayout as? CollectionViewFlowLayout else { return }
        flowLayout.invalidateLayout()
    }

}
// MARK: - CollectionViewFlowLayoutDelegate
extension MainViewController: CollectionViewFlowLayoutDelegate {
    func height(at indexPath: IndexPath) -> CGFloat {
        guard let cell = self.collectionView.cellForItem(at: indexPath) else {
            self.collectionView.reloadData()
            return 150
        }
        cell.layoutIfNeeded()
        //get calculated cell height
        return cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }

    func numberOfColumns() -> Int {
        return UIDevice.current.orientation == .portrait ? 1 : 2
    }
}
