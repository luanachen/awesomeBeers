//
//  BeerDetailViewModel.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

class BeerDetailViewModel: BeerDetailViewModelProtocol {

    private var selectedBeer: BeerElement!

    func setSelectedBeer(beer: BeerElement) {
        self.selectedBeer = beer
    }

    func getBeer() -> BeerElement {
        return selectedBeer
    }
    
}
