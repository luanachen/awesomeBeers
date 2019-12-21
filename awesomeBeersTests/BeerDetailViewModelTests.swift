//
//  BeerDetailViewModelTests.swift
//  protocolBeerTests
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

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
        let beer = viewModel.getBeer()
        XCTAssertEqual(beer.beerId, 1)
        XCTAssertEqual(beer.name, "Buzz")
        XCTAssertEqual(beer.description, "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
        XCTAssertEqual(beer.imageUrl, "https://images.punkapi.com/v2/keg.png")
        XCTAssertEqual(beer.abv, 4.5)
        XCTAssertEqual(beer.ibu, 60.0)
    }

}
