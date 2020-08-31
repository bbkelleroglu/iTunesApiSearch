//
//  UIViewController+AlertExtension.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 31.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import UIKit
extension UIViewController {

    func presentAlertWithTitle(title: String = "", message: String,
                               options: String...,
                               completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (_) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }

}
