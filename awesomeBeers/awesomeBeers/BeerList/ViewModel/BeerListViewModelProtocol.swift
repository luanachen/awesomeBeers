//
//  BeerListViewModelProtocol.swift
//  awesomeBeers
//
//  Created by Luana Chen on 04/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

protocol BeerListViewModelProtocol {
    
    func loadBeers()
    func getBeer(for row: Int) -> BeerElement?
    func getNumberOfItems() -> Int?
    func setSelectedBeer(beer: BeerElement)
    func getErrorMessage() -> String
}
