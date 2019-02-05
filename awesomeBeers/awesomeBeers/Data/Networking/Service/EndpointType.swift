//
//  Endpoint.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

protocol EndpointType {
    var base: String { get }
    var path: String { get }
}

extension EndpointType {
    var components: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }
    
    var request: URLRequest {
        let url = components.url!
        return URLRequest(url: url)
    }
    
}
