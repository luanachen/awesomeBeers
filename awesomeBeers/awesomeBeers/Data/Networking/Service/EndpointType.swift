//
//  Endpoint.swift
//  protocolBeer
//
//  Created by Luana Chen on 13/12/18.
//  Copyright © 2018 IDwall. All rights reserved.
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
