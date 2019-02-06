//
//  EndPoint.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

enum BeerEndpoint {
    case allBeers
}

extension BeerEndpoint: EndpointType {

    var base: String {
        return "https://api.punkapi.com"
    }

    var path: String {
        switch self {
        case .allBeers: return "/v2/beers"
        }
    }

}
