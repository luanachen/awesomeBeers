import Foundation

class BeerListViewModel {

    weak var delegate: BeerListViewControllerDelegate?

    private var dataProvider: DataProviderProtocol
    private var beers: [Beer]?
    private var errorMessage: String?

    init(dataProvider: DataProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
    }

    func loadBeers() {
        delegate?.didStartLoading()
        dataProvider.beerSession.getAllBeers { [weak self] result in
            switch result {
            case .success(let beers):
                guard let beers = beers else { return }
                self?.beers = beers
                self?.delegate?.didLoadWithSuccess()
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.delegate?.didLoadWithError()
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
        delegate?.didSelect(beer: selectedBeer)
    }

    func getErrorMessage() -> String {
        return errorMessage ?? "Ops, something is wrong..."
    }

}
