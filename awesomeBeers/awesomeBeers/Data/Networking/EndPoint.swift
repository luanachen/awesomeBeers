//
//  EndPoint.swift
//  protocolBeer
//
//  Created by Luana on 27/12/18.
//  Copyright © 2018 IDwall. All rights reserved.
//

import Foundation

// TODO: remove beer endpoint if not needed

enum BeerEndpoint {
    case allBeers
    case beer
}

extension BeerEndpoint: EndpointType {
    
    var base: String {
        return "https://api.punkapi.com"
    }
    
    var path: String {
        switch self {
        case .allBeers: return "/v2/beers"
        case .beer: return "/v2/beers"
        }
    }

}
