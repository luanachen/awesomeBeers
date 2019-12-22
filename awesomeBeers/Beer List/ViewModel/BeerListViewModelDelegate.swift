//
//  BeerListViewModelDelegate.swift
//  awesomeBeers
//
//  Created by Luana Chen on 04/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

protocol BeerListViewModelDelegate: class {

    func didLoad(success: Bool)
    func showLoadingIndicator(isLoading: Bool)
}

protocol BeerListViewModelCoordinatorDelegate: class {

    func didSelect(beer: Beer)
}
