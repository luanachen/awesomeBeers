//
//  DataProvider.swift
//  protocolBeer
//
//  Created by Luana on 16/12/18.
//  Copyright © 2018 IDwall. All rights reserved.
//

import Foundation

class DataProvider: DataProtocol {
    var beerSession: BeerSessionProtocol
    
    init() {
        self.beerSession = BeerSession()
    }
}
