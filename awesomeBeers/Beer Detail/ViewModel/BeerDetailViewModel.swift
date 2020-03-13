import Foundation

class BeerDetailViewModel {

    private var selectedBeer: Beer!

    init(beer: Beer) {
        self.selectedBeer = beer
    }

    func getBeer() -> Beer {
        return selectedBeer
    }
}
