import XCTest

class BeerListViewModelTests: XCTestCase {
    
    var sut: BeerListViewModel!
    var delegateMock: MockBeerListViewModelControllerDelegate!
    var sessionMock: MockBeerSessionProtocol!
    
    override func setUp() {
        super.setUp()
        delegateMock = MockBeerListViewModelControllerDelegate()
        sessionMock = MockBeerSessionProtocol()
        
        sut = BeerListViewModel(session: sessionMock)
        sut.delegate = delegateMock
        sut.loadBeers()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadBeersCallsSessionGetAllBeers() {
        XCTAssertTrue(sessionMock.didCallGetAllBeers)
    }
    
    func testLoadBeersSuccess() {
        XCTAssertTrue(delegateMock.didLoadSuccess)
        XCTAssertFalse(delegateMock.isLoading)
    }
    
    func testLoadBeersFail() {
        sessionMock.isSuccess = false
        sut.loadBeers()
        XCTAssertFalse(delegateMock.didLoadSuccess)
        XCTAssertFalse(delegateMock.isLoading)
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
        sut.didSelectRow(0)
        XCTAssertTrue(delegateMock.didCallDidSelect)
    }
    
    func testDidSelectRowPassesRightBeerToDelegate() {
        let expectedBeer = BeerFactory.build()
        sut.didSelectRow(0)
        XCTAssertEqual(delegateMock.selectedBeer, expectedBeer)
    }
    
}

class MockBeerListViewModelControllerDelegate: BeerListViewControllerDelegate {
    var didCallLoad = false
    var didLoadSuccess = false
    
    var didCallShowLoading = false
    var isLoading = false
    
    var didCallDidSelect = false
    var selectedBeer = Beer(beerId: 0,
                            name: "",
                            tagline: "",
                            description: "",
                            imageUrl: "",
                            abv: 0.0,
                            ibu: 0.0)
    
    func didLoad(success: Bool) {
        didCallLoad = true
        didLoadSuccess = success
    }
    
    func showLoadingIndicator(isLoading: Bool) {
        didCallShowLoading = true
        self.isLoading = isLoading
    }
    
    func didSelect(beer: Beer) {
        didCallDidSelect = true
        selectedBeer = beer
    }
}

class MockBeerSessionProtocol: BeerSessionProtocol {
    var didCallGetAllBeers = false
    var isSuccess: Bool = true
    
    func getAllBeers(completion: @escaping (Result<[Beer]?, APIError>) -> Void) {
        didCallGetAllBeers = true
        
        let beers = MockLoader().loadFile()
        if isSuccess {
            completion(.success(beers))
        } else {
            completion(.failure(APIError.invalidData))
        }
    }
}
