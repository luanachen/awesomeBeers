//
//  BeerSessionProtocol.swift
//  protocolBeer
//
//  Created by Luana on 16/12/18.
//  Copyright © 2018 IDwall. All rights reserved.
//

import Foundation

protocol BeerSessionProtocol {
    func getAllBeers(completion: @escaping (Result<[BeerElement]?, APIError>) -> Void)
    func getBeer(withName name: String, completion: @escaping (Result<[BeerElement]?, APIError>) -> Void)
}
