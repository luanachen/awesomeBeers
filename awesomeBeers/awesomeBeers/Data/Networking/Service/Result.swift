//
//  Result.swift
//  protocolBeer
//
//  Created by Luana Chen on 13/12/18.
//  Copyright © 2018 IDwall. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
