import Foundation
import NetworkHelper

protocol BeerSessionProtocol {
    func getAllBeers(completion: @escaping (Result<[Beer]?, APIError>) -> Void)
}
