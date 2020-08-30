//
//  MainCell.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 29.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import UIKit
class MainCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    // MARK: - Variables
    var results: SearchModel? {
        didSet {
            if let results = results {
                nameLabel.text = results.artistName
                thumbnailImage.downloaded(from: results.artworkUrl100)
            }
        }
    }
}
