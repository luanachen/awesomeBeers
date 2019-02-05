//
//  Beer.swift
//  awesomeBeers
//
//  Created by Luana Chen on 04/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

struct BeerResult: Decodable {
    let beer: [BeerElement]?
}

struct BeerElement: Decodable {
    let beerId: Int
    let name, tagline, description: String
    let imageURL: String
    let abv: Double
    let ibu: Double?

    enum CodingKeys: String, CodingKey {
        case beerId = "id"
        case name, tagline
        case description
        case imageURL = "image_url"
        case abv, ibu
    }
}

struct BeerParameter: Encodable {
    let name: String
}
