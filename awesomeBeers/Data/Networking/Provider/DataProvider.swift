import Foundation

class DataProvider: DataProtocol {
    var beerSession: BeerSessionProtocol

    init() {
        self.beerSession = BeerSession()
    }
}
