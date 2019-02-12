//
//  BeerSession.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation
import RxSwift

class BeerSession: BeerSessionProtocol, APIClient {

    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getAllBeers() -> Observable<[BeerElement]> {
        let endPoint = BeerEndpoint.allBeers
        var request = endPoint.request
        request.httpMethod = HTTPMethod.get.rawValue

        return Observable.create({ observer -> Disposable in

            self.fetch(with: request, decode: { json -> [BeerElement]? in

                guard let beerResult = json as? [BeerElement] else { return nil }
                return beerResult

            }, completion: { (result) in
                switch result {
                case .success(let beers):
                    observer.onNext(beers)
                case .failure(let error):
                    observer.onError(error)
                }
            })
            return Disposables.create()
        })
    }

}
