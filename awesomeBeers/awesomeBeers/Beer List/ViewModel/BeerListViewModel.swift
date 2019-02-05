//
//  BeerListViewModel.swift
//  awesomeBeers
//
//  Created by Luana Chen on 04/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

class BeerListViewModel: BeerListViewModelProtocol {
    
    weak var delegate: BeerListViewModelDelegate?
    
    private var beers: [BeerElement]!
    
    private var errorMessage: String!
    
    var selectedBeer: BeerElement!
    
    func loadBeers() {
        loadFile()
    }
    
    fileprivate func loadFile() {
        let url = Bundle.main.url(forResource: "beerList", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let beerData = try JSONDecoder().decode([BeerElement].self, from: jsonData)
            self.beers = beerData
        } catch {
            fatalError("could not read from mocked json")
        }
    }
    
    func getNumberOfItems() -> Int? {
        return beers != nil ? beers.count : 0
    }
    
    func getBeer(for row: Int) -> BeerElement?  {
        guard let beers = beers else { return nil }
        return beers[row]
    }
    
    func setSelectedBeer(beer: BeerElement) {
        self.selectedBeer = beer
    }
    
    func getErrorMessage() -> String {
        return errorMessage
    }
    
}
