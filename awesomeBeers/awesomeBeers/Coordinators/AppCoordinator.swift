//
//  AppCoordinator.swift
//  awesomeBeers
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow
    var beerListCoordinator: BeerListCoordinator?
    
    private let navigation: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigation
        beerListCoordinator = BeerListCoordinator(navigation: navigation)
        beerListCoordinator?.start()
    }
}
