//
//  DetailViewController.swift
//  iTunesApiSearch
//
//  Created by Burak Kelleroğlu on 30.08.2020.
//  Copyright © 2020 Burak Kelleroglu. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, StoryboardLoadable, Instantiatable {
    static var defaultStoryboardName = "Main"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageViewBackground: UIImageView!

    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        addRightNavButton(image: .remove)
        setupUI()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserActivities.setItemAsVisited(with: String(viewModel.detailViewModel.trackId))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavigationBarColor(color: .clear)
    }
    override func rightBarButtonTapped() {
        presentAlertWithTitle(message: "This item will be deleted permanently.",
                              options: "Remove",
                              "Cancel") { [weak self] action in
            guard let self = self else { return }
            switch action {
            case 0:
                UserActivities.setRemovedItem(with: String(self.viewModel.detailViewModel.trackId))
            case 1:
                break
            default:
                break
            }
        }
    }

    static func instantiate(with model: DetailViewModel) -> Self {
        let viewController = loadFromStoryboard()
        viewController.viewModel = model
        return viewController
    }
    func setupUI() {
        self.navigationItem.title = "Detail"
        titleLabel.text = viewModel.detailViewModel.trackCensoredName
        countryLabel.text = viewModel.detailViewModel.country
        artistNameLabel.text = viewModel.detailViewModel.artistName
        imageView.downloaded(from: viewModel.detailViewModel.artworkUrl100)
        imageViewBackground.downloaded(from: viewModel.detailViewModel.artworkUrl100)
        collectionNameLabel.text = viewModel.detailViewModel.collectionName
        descriptionLabel.text = viewModel.detailViewModel.artistName
    }
}
