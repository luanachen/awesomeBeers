//
//  BeerSession.swift
//  protocolBeer
//
//  Created by Luana on 16/12/18.
//  Copyright © 2018 IDwall. All rights reserved.
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
    
    // TODO: remove method bellow if not needed
    
    func getBeer(withName name: String, completion: @escaping (Result<[BeerElement]?, APIError>) -> Void) {
        let endPoint = BeerEndpoint.beer
        var components = URLComponents(string: endPoint.base)
        components?.path = endPoint.path
        components?.queryItems = [URLQueryItem(name: "name", value: name)]
        let request = URLRequest(url: (components?.url)!)
        
        fetch(with: request, decode: { json -> [BeerElement]? in
            guard let beerResult = json as? [BeerElement] else { return nil }
            return beerResult
        }, completion: completion)
    }
    
}
