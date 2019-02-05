//
//  AppDelegate.swift
//  awesomeBeers
//
//  Created by Luana Chen on 04/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
        window?.makeKeyAndVisible()

        return true
    }

}

