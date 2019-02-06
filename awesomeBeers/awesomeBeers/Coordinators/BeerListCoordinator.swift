//
//  BeerListCoordinator.swift
//  awesomeBeers
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import UIKit

class BeerListCoordinator: Coordinator {

    var navigation: UINavigationController?

    var beerListViewModel: BeerListViewModel?
    var beerListViewController: BeerListViewController?

    var beerDetailViewModel: BeerDetailViewModel?
    var beerDetailViewController: BeerDetailViewController?

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start() {
        beerListViewModel = BeerListViewModel(delegate: self)
        beerListViewController = BeerListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        beerListViewController?.viewModel = beerListViewModel
        guard let viewController = beerListViewController else { return }
        navigation?.pushViewController(viewController, animated: true)
    }
}

extension BeerListCoordinator: BeerListViewModelCoordinatorDelegate {
    func didSelect(beer: BeerElement) {
        beerDetailViewModel = BeerDetailViewModel(beer: beer)

        guard let viewModel = beerDetailViewModel else { return }
        beerDetailViewController = BeerDetailViewController(viewModel: viewModel)
        guard let viewController = beerDetailViewController else { return }
        navigation?.pushViewController(viewController, animated: true)
    }
}
