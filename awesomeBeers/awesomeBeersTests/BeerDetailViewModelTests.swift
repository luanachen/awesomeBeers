//
//  BeerDetailViewModelTests.swift
//  protocolBeerTests
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import XCTest

class BeerDetailViewModelTests: XCTestCase {
    
    var sut: BeerDetailViewModel!
    
    override func setUp() {
        super.setUp()
        sut = BeerDetailViewModel()
        
        let beer = MockLoader().loadFile()
        sut.setSelectedBeer(beer: beer.first!)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetSelectedBeerNotNil() {
        XCTAssertNotNil(sut.getBeer())
    }
    
    func testGetBeerInfCorrectly() {
        let beer = sut.getBeer()
        XCTAssertEqual(beer.id, 1)
        XCTAssertEqual(beer.name, "Buzz")
        XCTAssertEqual(beer.description, "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.")
        XCTAssertEqual(beer.imageURL, "https://images.punkapi.com/v2/keg.png")
        XCTAssertEqual(beer.abv, 4.5)
        XCTAssertEqual(beer.ibu, 60.0)
    }
    
}
