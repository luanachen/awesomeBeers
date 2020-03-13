import XCTest

class BeerListViewControllerTests: XCTestCase {
    
    var sut: BeerListViewController!
    var delegateMock: BeerListViewModelCoordinatorDelegateMock!
    
    override func setUp() {
        super.setUp()
        delegateMock = BeerListViewModelCoordinatorDelegateMock()
        sut = BeerListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        sut.delegate = delegateMock
        sut.loadView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDidSelectCallsDelegateWithCorrectBeer() {
        let expectedBeer = BeerFactory.build()
        sut.didSelect(beer: expectedBeer)
        
        XCTAssertTrue(delegateMock.didCallDidSelect)
        XCTAssertEqual(delegateMock.selectedBeer, expectedBeer)
    }
}

class BeerListViewModelCoordinatorDelegateMock: BeerListViewModelCoordinatorDelegate {
    var didCallDidSelect = false
    
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
