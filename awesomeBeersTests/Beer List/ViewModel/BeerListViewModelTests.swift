import XCTest

class BeerListViewModelTests: XCTestCase {
    
    var sut: BeerListViewModel!
    var delegateMock: MockBeerListViewModelControllerDelegate!
    var dataProvider: MockDataProvider!
    var sessionMock: MockBeerSessionProtocol!
    
    override func setUp() {
        super.setUp()
        delegateMock = MockBeerListViewModelControllerDelegate()
        sessionMock = MockBeerSessionProtocol()
        dataProvider = MockDataProvider(beerSession: sessionMock)

        sut = BeerListViewModel(dataProvider: dataProvider)
        sut.delegate = delegateMock
    }
    
    override func tearDown() {
        sut = nil
        delegateMock = nil
        dataProvider = nil
        sessionMock = nil
        super.tearDown()
    }
    
    func testLoadBeersCallsSessionGetAllBeersWithSuccess() {
        sut.loadBeers()
        XCTAssertTrue(delegateMock.startLoading)
        XCTAssertTrue(delegateMock.loadWithSuccess)
    }

    func testLoadBeersCallsSessionGetAllBeersWithError() {
        sessionMock.isNetworkSuccess = false
        sut.loadBeers()
        XCTAssertTrue(delegateMock.startLoading)
        XCTAssertTrue(delegateMock.loadWithError)
    }

    func testGetNumberOfItemsNotNil() {
        XCTAssertNotNil(sut.getNumberOfItems())
    }
    
    func testGetBeerInfCorrectly() {
        guard let beer = sut.getBeer(for: 0) else { return }
        let expectedBeer = BeerFactory.build()
        XCTAssertEqual(beer, expectedBeer)
    }
    
    func testDidSelectRowCallsDelegateDidSelect() {
        sut.loadBeers()
        sut.didSelectRow(0)
        XCTAssertTrue(delegateMock.didCallDidSelect)
    }
    
    func testDidSelectRowPassesRightBeerToDelegate() {
        sut.loadBeers()
        let expectedBeer = BeerFactory.build()
        sut.didSelectRow(0)
        XCTAssertEqual(delegateMock.selectedBeer, expectedBeer)
    }
    
}

class MockBeerListViewModelControllerDelegate: BeerListViewControllerDelegate {
    var startLoading = false
    var loadWithSuccess = false
    var loadWithError = false
    var didCallDidSelect = false
    var selectedBeer = Beer(beerId: 0,
                            name: "",
                            tagline: "",
                            description: "",
                            imageUrl: "",
                            abv: 0.0,
                            ibu: 0.0)

    func didStartLoading() {
        startLoading = true
    }

    func didLoadWithSuccess() {
        loadWithSuccess = true
    }

    func didLoadWithError() {
         loadWithError = true
    }

    func didSelect(beer: Beer) {
        didCallDidSelect = true
        selectedBeer = beer
    }
}

import NetworkHelper

class MockDataProvider: DataProviderProtocol {
    var beerSession: BeerSessionProtocol

    init(beerSession: BeerSessionProtocol = MockBeerSessionProtocol()) {
        self.beerSession = beerSession
    }
}

class MockBeerSessionProtocol: BeerSessionProtocol {
    var isNetworkSuccess: Bool = true

    func getAllBeers(completion: @escaping (Result<[Beer]?, APIError>) -> Void) {
        let beers = MockLoader().loadFile()
        if isNetworkSuccess {
            completion(.success(beers))
        } else {
            completion(.failure(APIError.invalidData))
        }
    }
}
