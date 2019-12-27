import XCTest

class BeerListViewModelTests: XCTestCase {

    var sut: BeerListViewModel!
    var delegateMock: MockBeerListViewModelControllerDelegate!

    override func setUp() {
        super.setUp()
        delegateMock = MockBeerListViewModelControllerDelegate()
        sut = BeerListViewModel()
        sut.delegate = delegateMock
        sut.loadBeers()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadBeers() {
        XCTAssertTrue(delegateMock.didCallShowLoading)
        XCTAssertTrue(delegateMock.didCallLoad)
    }

    func testGetNumberOfItemsNotNil() {
        XCTAssertNotNil(sut.getNumberOfItems())
    }

    func testGetBeerInfCorrectly() {
        guard let beer = sut.getBeer(for: 0) else { return }
        XCTAssertEqual(beer.beerId, 1)
        XCTAssertEqual(beer.name, "Buzz")
        XCTAssertEqual(beer.description, "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
        XCTAssertEqual(beer.imageUrl, "https://images.punkapi.com/v2/keg.png")
    }
    
    func testDidSelectRowCallsDelegateDidSelect() {
        sut.didSelectRow(0)
        XCTAssertTrue(delegateMock.didCallDidSelect)
    }
    
    func testDidSelectRowPassesRightBeerToDelegate() {
        let expectedBeer = Beer(beerId: 1,
                                name: "Buzz",
                                tagline: "A Real Bitter Experience.",
                                description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
                                imageUrl: "https://images.punkapi.com/v2/keg.png",
                                abv: 4.5,
                                ibu: 60)

        sut.didSelectRow(0)
        XCTAssertEqual(delegateMock.selectedBeer, expectedBeer)
    }

}

class MockBeerListViewModelControllerDelegate: BeerListViewControllerDelegate {
    var didCallLoad = false
    var didCallShowLoading = false
    var didCallDidSelect = false

    func didLoad(success: Bool) {
        didCallLoad = true
    }
    
    func showLoadingIndicator(isLoading: Bool) {
        didCallShowLoading = true
    }
    
    var selectedBeer = Beer(beerId: 0,
                            name: "",
                            tagline: "",
                            description: "",
                            imageUrl: "",
                            abv: 0.0,
                            ibu: 0.0)
    
    func didSelect(beer: Beer) {
        didCallDidSelect = true
        selectedBeer = beer
    }
}
