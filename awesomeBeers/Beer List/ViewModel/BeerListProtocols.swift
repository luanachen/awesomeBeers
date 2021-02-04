import Foundation

protocol BeerListViewControllerDelegate: class {
    func didStartLoading()
    func didLoadWithSuccess()
    func didLoadWithError()
    func didSelect(beer: Beer)
}

protocol BeerListViewModelCoordinatorDelegate: class {
    func didSelect(beer: Beer)
}
