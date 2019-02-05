//
//  DataProvider.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

class DataProvider: DataProtocol {
    var beerSession: BeerSessionProtocol
    
    init() {
        self.beerSession = BeerSession()
    }
}
