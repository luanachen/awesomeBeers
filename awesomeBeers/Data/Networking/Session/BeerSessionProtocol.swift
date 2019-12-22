import Foundation

protocol BeerSessionProtocol {
    func getAllBeers(completion: @escaping (Result<[Beer]?, APIError>) -> Void)
}
