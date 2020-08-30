//
//  MainViewModel.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 29.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
struct MainViewState {
    fileprivate(set) var items: [SearchModel] = []

    mutating func setItems(_ items: [SearchModel]) {
        self.items = items
    }
}
class MainViewModel {
    // MARK: - Variables
    private(set) var state = MainViewState()
    // MARK: - CollectionView
    var numberOfItem: Int {
        return state.items.count
    }
    func itemAtIndex(_ index: Int) -> SearchModel? {
        if state.items.count > index {
            return state.items[index]
        }
        return nil
    }
    // MARK: - Service
    func fetchItems(text: String = "", limit: Int, completion: @escaping () -> Void) {
        NetworkManager.shared.search(text: text, limit: limit, completion: { result in
            self.state.setItems(result!)
            completion()
        }) { _ in
            print(NetworkError.failed.rawValue)
        }
    }
}
