//
//  BeerListViewModelTests.swift
//  protocolBeerTests
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import XCTest

class BeerListViewModelTests: XCTestCase {

    var sut: BeerListViewModel!

    override func setUp() {
        super.setUp()
        sut = BeerListViewModel(delegate: self)
        sut.loadBeers()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetNumberOfItemsNotNil() {
        XCTAssertNotNil(sut.getNumberOfItems())
    }

    func testBeerNameAtFirstIndexEqualToBuzz() {
        let beer = sut.getBeer(for: 0)

        XCTAssertEqual(beer?.name, "Buzz")
    }

    func testGetBeerInfCorrectly() {
        guard let beer = sut.getBeer(for: 0) else { return }
        XCTAssertEqual(beer.beerId, 1)
        XCTAssertEqual(beer.name, "Buzz")
        XCTAssertEqual(beer.description, "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
        XCTAssertEqual(beer.imageURL, "https://images.punkapi.com/v2/keg.png")
    }

}

extension BeerListViewModelTests: BeerListViewModelCoordinatorDelegate {
    func didSelect(beer: BeerElement) {
    }
}
