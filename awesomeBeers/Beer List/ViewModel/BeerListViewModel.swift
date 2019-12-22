import Foundation

class BeerListViewModel {

    weak var viewModelCoordinatorDelegate: BeerListViewModelCoordinatorDelegate?
    weak var viewDelegate: BeerListViewModelDelegate?

    private var beers: [Beer]?
    private var errorMessage: String?

    init(delegate: BeerListViewModelCoordinatorDelegate) {
        self.viewModelCoordinatorDelegate = delegate
    }

    func loadBeers() {

        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            beers = MockLoader().loadFile()
        }
        #endif

        self.viewDelegate?.showLoadingIndicator(isLoading: true)

        Facade.shared.dataProvider.beerSession.getAllBeers { result in
            switch result {
            case .success(let beers):
                guard let beers = beers else { return }
                self.beers = beers
                self.viewDelegate?.didLoad(success: true)
                self.viewDelegate?.showLoadingIndicator(isLoading: false)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.viewDelegate?.didLoad(success: false)
                self.viewDelegate?.showLoadingIndicator(isLoading: false)
                print("the error \(error)")
            }
        }
    }

    func getNumberOfItems() -> Int {
        return beers?.count ?? 0
    }

    func getBeer(for row: Int) -> Beer? {
        guard let beers = beers else { return nil }
        return beers[row]
    }

    func didSelectRow(_ row: Int) {
        guard let selectedBeer = beers?[row] else { return }
        viewModelCoordinatorDelegate?.didSelect(beer: selectedBeer)
    }

    func getErrorMessage() -> String {
        return errorMessage ?? "Ops, something is wrong..."
    }

}
