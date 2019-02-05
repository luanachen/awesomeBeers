//
//  MockDataLoader.swift
//  protocolBeer
//
//  Created by Luana on 29/12/18.
//  Copyright © 2018 IDwall. All rights reserved.
//

import Foundation

class MockLoader {
    
    func loadFile() -> [BeerElement] {
        var beers = [BeerElement]()
        let url = Bundle.main.url(forResource: "beerList", withExtension: "json")!
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
