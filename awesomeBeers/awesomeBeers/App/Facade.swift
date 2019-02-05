//
//  Facade.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

class Facade: NSObject {
    
    static var shared: Facade = Facade()
    var dataProvider: DataProvider!
    
    override init() {
        super.init()
        self.dataProvider = DataProvider()
    }
}
