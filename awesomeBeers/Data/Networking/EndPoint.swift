import Foundation
import NetworkHelper

enum BeerEndpoint {
    case allBeers
}

extension BeerEndpoint: EndpointType {

    var base: String {
        return "https://api.punkapi.com"
    }

    var path: String {
        switch self {
        case .allBeers: return "/v2/beers"
        }
    }

}
