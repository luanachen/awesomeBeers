//
//  MockDataLoader.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

class MockLoader {

    func loadFile() -> [BeerElement]? {
        var beers = [BeerElement]()
        guard let url = Bundle.main.url(forResource: "beerList", withExtension: "json") else { return nil}
        do {
            let jsonData = try Data(contentsOf: url)
            let beerData = try JSONDecoder().decode([BeerElement].self, from: jsonData)
            beers = beerData
        } catch {
            fatalError("Couldn't load json file")
        }
        return beers
    }
}
