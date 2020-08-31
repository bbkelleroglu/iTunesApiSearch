//
//  BaseViewController.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 30.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: NavigationItems
    // MARK: Right button
    func addRightNavButton(image: UIImage) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }

    @objc func rightBarButtonTapped() { }

    // MARK: Back button
    func addBackNavButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .checkmark,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backBarButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }

    @objc func backBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    func applyNavigationBarColor(color: UIColor) {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage().withTintColor(color), for: .default)
        navigationController.view.backgroundColor = .clear
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.backgroundColor = .clear
    }
}
