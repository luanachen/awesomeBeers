import Kingfisher
import UIKit

private enum Constants {
    static let AccessibilityIdentifier = "beerListView"
    static let NavigationTitle = "Awesome Beers"
}

private enum ViewConstants {
    static let IndicatorDimensions: CGFloat = 40
}

class BeerListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: BeerListViewModelCoordinatorDelegate?
    
    var viewModel: BeerListViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.delegate = self
        }
    }
    
    private var indicator = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.NavigationTitle
        view.accessibilityIdentifier = Constants.AccessibilityIdentifier

        let rightItem = UIBarButtonItem(image: UIImage(systemName: "book"), style: .plain, target: self, action: #selector(openCV))
        navigationItem.rightBarButtonItem = rightItem
        
        viewModel?.loadBeers()
        setupCollectionView()
        setupIndicatorView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    @objc func openCV() {
        delegate?.openCV()
    }
    
    private func setupCollectionView() {
        collectionView.accessibilityIdentifier = "CollectionView"
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
        indicator.style = .medium
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
        return viewModel?.getNumberOfItems() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerListCell.identifier, for: indexPath) as? BeerListCell else { return UICollectionViewCell() }
        if let viewModel = viewModel, let beer = viewModel.getBeer(for: indexPath.item)  {
            cell.show(beer: beer)
        }
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelectRow(indexPath.item)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
}

// MARK: - BeerListViewModelDelegate

extension BeerListViewController: BeerListViewControllerDelegate {
    
    func showLoadingIndicator(isLoading: Bool) {
        if isLoading {
            self.indicator.startAnimating()
        } else {
            self.indicator.stopAnimating()
        }
    }
    
    func didLoad(success: Bool) {
        DispatchQueue.main.async {
            if success {
                self.collectionView.reloadData()
            } else {
                self.showError(message: self.viewModel?
                    .getErrorMessage() ?? "Error")
            }
        }
    }
    
    func didSelect(beer: Beer) {
        delegate?.didSelect(beer: beer)
    }
    
}

// MARK: - PinterestLayoutDelegate

extension BeerListViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: viewModel?.getBeer(for: indexPath.item)?.imageUrl ?? ""), placeholder: #imageLiteral(resourceName: "placeholder"))
        guard let height = imageView.image?.size.height else { return 0 }
        return height * CGFloat(0.4)
    }
}
