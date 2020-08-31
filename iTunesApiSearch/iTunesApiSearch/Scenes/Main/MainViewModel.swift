//
//  MainViewModel.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 29.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import Foundation
struct MainViewState {
    var items: [SearchModel] = []
}
class MainViewModel {
    // MARK: - Variables
    private(set) var state: MainViewState
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
    init(state: MainViewState = MainViewState()) {
        self.state = state
    }
    // MARK: - Service
    func fetchItems(text: String = "", limit: Int, completion: @escaping () -> Void) {
        NetworkManager.shared.search(text: text,
                                     limit: limit,
                                     completion: { result in
                                        self.state.items = result!
                                        self.removeItemFromList()
                                        completion()
                                        // swiftlint:disable:next multiple_closures_with_trailing_closure
        }) { error in
            print(error)
        }
    }
    // MARK: - User Activities
    func isVisitedBefore(index: Int) -> Bool {
        guard
            let currentItem = itemAtIndex(index),
            let visitedItems = UserActivities.getVisitedItems(),
            visitedItems.contains(String(currentItem.trackId))
            else { return false }
        return true
    }
    func removeItemFromList() {
        guard let removedItems = UserActivities.getRemovedItems() else { return }
        state.items = state.items.filter {!removedItems.contains(String($0.trackId))}
    }
}
