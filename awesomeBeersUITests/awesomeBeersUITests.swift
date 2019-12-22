import XCTest

class awesomeBeersUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()

        XCUIApplication().launch()
    }

    override func tearDown() {

        super.tearDown()
    }

    func testSelectFirstItemAndBackToList() {
        app.launch()

        XCTAssertTrue(app.isDisplayingBeerListView)

        XCTAssertTrue(app.isDisplayingBeerWithNameBuzz)

        app.collectionViews.cells.otherElements.containing(.staticText, identifier: "Buzz").element.tap()

        XCTAssertTrue(app.isDisplayingBeerDetailView)

        XCTAssertTrue(app.isDisplayingNavigationBarWithNameBuzz)

        app.navigationBars["Buzz"].buttons["Awesome Beers"].tap()

        XCTAssertTrue(app.isDisplayingNavigationBarWithNameAwesomeBeers)
    }

}

extension XCUIApplication {
    var isDisplayingBeerListView: Bool {
        return otherElements["beerListView"].exists
    }

    var isDisplayingBeerDetailView: Bool {
        return otherElements["beerDetailView"].exists
    }

    var isDisplayingBeerWithNameBuzz: Bool {
        return collectionViews.cells.otherElements.containing(.staticText, identifier: "Buzz").element.exists
    }

    var isDisplayingNavigationBarWithNameBuzz: Bool {
        return otherElements.containing(.navigationBar, identifier: "Buzz").element.exists
    }

    var isDisplayingNavigationBarWithNameAwesomeBeers: Bool {
        return  otherElements.containing(.navigationBar, identifier: "Awesome Beers").element.exists
    }
}
