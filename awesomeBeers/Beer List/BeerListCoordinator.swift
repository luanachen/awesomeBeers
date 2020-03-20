import UIKit

class BeerListCoordinator: CoordinatorProtocol {
    
    var navigation: UINavigationController?

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let viewController = createBeerListViewController()
        navigation?.pushViewController(viewController, animated: true)
    }
    
    private func createBeerListViewController() -> BeerListViewController {
        let viewModel = BeerListViewModel()
        let viewController = BeerListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewController.viewModel = viewModel
        viewController.delegate = self
        return viewController
    }
    
    private func createBeerDetailViewController(beer: Beer) -> BeerDetailViewController {
        let viewModel = BeerDetailViewModel(beer: beer)
        let viewController = BeerDetailViewController(viewModel: viewModel)
        return viewController
    }
}

extension BeerListCoordinator: BeerListViewModelCoordinatorDelegate {
    func didSelect(beer: Beer) {
        
        
        let viewController = createBeerDetailViewController(beer: beer)
        navigation?.pushViewController(viewController, animated: true)
    }
}
