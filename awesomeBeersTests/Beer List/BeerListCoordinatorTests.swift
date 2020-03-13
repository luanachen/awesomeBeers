import XCTest

class BeerListCoordinatorTests: XCTestCase {
    
    var sut: BeerListCoordinator!
    var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        sut = BeerListCoordinator(navigation: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testStartHasCorrectyViewController() {
        sut.start()
        XCTAssert(type(of: navigationController.viewControllers[0]) is BeerListViewController.Type)
    }
    
    func testDidSelectHasCorrectyViewController() {
        let beer = Beer(beerId: 0,
                        name: "",
                        tagline: "",
                        description: "",
                        imageUrl: "",
                        abv: 0.0,
                        ibu: 0.0)
        sut.didSelect(beer: beer)
        XCTAssert(type(of: navigationController.viewControllers[0]) is BeerDetailViewController.Type)
    }
}

