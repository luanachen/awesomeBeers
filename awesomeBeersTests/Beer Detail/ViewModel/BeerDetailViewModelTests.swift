import XCTest

class BeerDetailViewModelTests: XCTestCase {
    
    var viewModel: BeerDetailViewModel!
    
    override func setUp() {
        super.setUp()
        guard let beer = MockLoader().loadFile() else { return }
        viewModel = BeerDetailViewModel(beer: beer[0])
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetSelectedBeerNotNil() {
        XCTAssertNotNil(viewModel.getBeer())
    }
    
    func testGetBeerInfCorrectly() {
        let expectedBeer = BeerFactory.build()
        let beer = viewModel.getBeer()
        
        XCTAssertEqual(beer, expectedBeer)
    }
}
