struct BeerDetailViewModelFactory {
    static func build() -> BeerDetailViewModel {
        return BeerDetailViewModel(beer: BeerFactory.build())
    }
}
