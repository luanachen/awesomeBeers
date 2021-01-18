//
//  CVViewController.swift
//  awesomeBeers
//
//  Created by Luana Chen Chih Jun on 15/01/21.
//  Copyright © 2021 Luana Chen. All rights reserved.
//

import SwiftUI
import UIKit

class CVViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "John Doe's Virtual CV"

        let cvViewModel = CVViewViewModel()
        let cvViewController = UIHostingController(rootView: CVView(viewModel: cvViewModel))

        addChild(cvViewController)
        view.addSubview(cvViewController.view)
        cvViewController.view.fillSuperview()
    }
}
