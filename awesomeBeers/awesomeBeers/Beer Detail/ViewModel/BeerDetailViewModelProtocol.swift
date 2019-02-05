//
//  BeerDetailViewModelProtocol.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

protocol BeerDetailViewModelProtocol {

    func setSelectedBeer(beer: BeerElement)

    func getBeer() -> BeerElement
    
}
