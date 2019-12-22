import Foundation

protocol BeerListViewModelDelegate: class {

    func didLoad(success: Bool)
    func showLoadingIndicator(isLoading: Bool)
}

protocol BeerListViewModelCoordinatorDelegate: class {

    func didSelect(beer: Beer)
}
