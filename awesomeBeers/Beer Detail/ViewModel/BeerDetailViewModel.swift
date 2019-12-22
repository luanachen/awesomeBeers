//
//  BeerDetailViewModel.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

class BeerDetailViewModel {

    private var selectedBeer: Beer!

    init(beer: Beer) {
        self.selectedBeer = beer
    }

    func getBeer() -> Beer {
        return selectedBeer
    }

}
