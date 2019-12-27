import Foundation

protocol BeerListViewControllerDelegate: class {
    func didLoad(success: Bool)
    func showLoadingIndicator(isLoading: Bool)
    func didSelect(beer: Beer)
}

protocol BeerListViewModelCoordinatorDelegate: class {
    func didSelect(beer: Beer)
}
