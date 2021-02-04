import Foundation

class DataProvider: DataProviderProtocol {
    var beerSession: BeerSessionProtocol

    init() {
        self.beerSession = BeerSession()
    }
}
