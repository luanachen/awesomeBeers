//
//  BeerDetailViewController.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import UIKit
import Kingfisher

class BeerDetailViewController: UIViewController {
    
    let detailView: DetailView!
    
    let viewModel = BeerDetailViewModel()
    
    
    init() {
        detailView = DetailView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "beerDetailView"

        setupView()
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = viewModel.getBeer().name
    }
    
    fileprivate func setupView() {
        
        view.addSubview(detailView)
        
        if #available(iOS 11.0, *) {
            detailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        } else {
            detailView.anchor(top: topLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        }
    
    }
    
    private func bindView() {
        detailView.bindView(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

