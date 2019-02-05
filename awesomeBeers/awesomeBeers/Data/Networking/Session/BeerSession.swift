//
//  BeerSession.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

class BeerSession: BeerSessionProtocol, APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getAllBeers(completion: @escaping (Result<[BeerElement]?, APIError>) -> Void) {
        let endPoint = BeerEndpoint.allBeers
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue
        
        fetch(with: request, decode: { json -> [BeerElement]? in
            guard let beerResult = json as? [BeerElement] else { return nil }
            return beerResult
        }, completion: completion)
    }
    
}
