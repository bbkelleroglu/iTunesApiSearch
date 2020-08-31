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
//        collectionFlowLayout()
        dataSource = MainViewDataSource(viewModel: viewModel)
        collectionView.dataSource = dataSource
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
        viewModel.removeItemFromList()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCollectionViewCellSize()
    }
    // MARK: - Fetching Items
    func fetchItems() {
        viewModel.fetchItems(text: "Solomun", limit: 10, completion: {
                self.setCollectionViewCellSize()
                self.collectionView.reloadData()
        })
    }

    func setCollectionViewCellSize() {
        let columns = UIDevice.current.orientation.isLandscape ? 2 : 1
        let size = CGSize(width: Int(collectionView.frame.width) / columns - 10, height: 150)
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = size
        layout?.invalidateLayout()
        print("itemSize: \(size)")
    }
}
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let mainCell = (cell as? MainCell), viewModel.isVisitedBefore(index: indexPath.row) {
            mainCell.setItemAsVisited()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchModel = viewModel.itemAtIndex(indexPath.row)
        let model = DetailViewModel(with: searchModel!)
        let detailVc = DetailViewController.instantiate(with: model)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }

}
