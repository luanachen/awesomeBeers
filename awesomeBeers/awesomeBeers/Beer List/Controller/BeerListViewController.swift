//
//  ViewController.swift
//  awesomeBeers
//
//  Created by Luana Chen on 04/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import UIKit
import Kingfisher

private enum Constants {
    static let AccessibilityIdentifier = "beerListView"
    static let NavigationTitle = "Awesome Beers"
}

private enum ViewConstants {
    static let IndicatorDimensions: CGFloat = 40
}

class BeerListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var viewModel: BeerListViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    private var indicator = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.NavigationTitle
        view.accessibilityIdentifier = Constants.AccessibilityIdentifier
        
        viewModel.loadBeers()
        setupCollectionView()
        setupIndicatorView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Private func
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(BeerListCell.self, forCellWithReuseIdentifier: BeerListCell.identifier)
        
        collectionView.collectionViewLayout = PinterestLayout()
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    
    private func setupIndicatorView() {
        indicator = UIActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: ViewConstants.IndicatorDimensions, height: ViewConstants.IndicatorDimensions)))
        indicator.style = .gray
        indicator.center = collectionView.center
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func showError(message: String) {
        let alert = UIAlertController.init(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    // MARK: - UICollectiionView Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerListCell.identifier, for: indexPath) as? BeerListCell else { return UICollectionViewCell() }
        
        cell.bindView(with: viewModel, for: indexPath.item)
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.item)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
}

// MARK: - BeerListViewModelDelegate

extension BeerListViewController: BeerListViewModelDelegate {
    
    func showLoadingIndicator(isLoading: Bool) {
        if isLoading {
            self.indicator.startAnimating()
        } else {
            self.indicator.stopAnimating()
        }
    }
    
    func didLoad(success: Bool) {
        if success {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            DispatchQueue.main.async {
                self.showError(message: self.viewModel.getErrorMessage())
            }
        }
    }
    
}

// MARK: - PinterestLayoutDelegate

extension BeerListViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: viewModel.getBeer(for: indexPath.item)?.imageURL ?? ""), placeholder: #imageLiteral(resourceName: "placeholder"))
        return (imageView.image?.size.height)! * CGFloat(0.4)
    }
}
