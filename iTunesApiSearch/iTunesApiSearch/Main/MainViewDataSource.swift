//
//  MainViewDataSource.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 29.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import UIKit
class MainViewDataSource: NSObject {
    fileprivate let viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}
extension MainViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell",
                                                            for: indexPath) as? MainCell else {
                                                                return UICollectionViewCell() }
        cell.results = viewModel.itemAtIndex(indexPath.row)
        return cell
    }
}
