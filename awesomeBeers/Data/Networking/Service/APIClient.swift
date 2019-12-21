//
//  APIClient.swift
//  protocolBeer
//
//  Created by Luana Chen on 05/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

protocol APIClient {

    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {

        let task = session.dataTask(with: request) { data, response, error in

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "No description"))
                return
            }
            guard httpResponse.statusCode == 200  else {
                completion(nil, .responseUnsuccessful(description: "\(httpResponse.statusCode)"))
                return
            }

            guard let data = data else { completion(nil, .invalidData); return }

            do {
                let decoder = JSONDecoder()
                let genericModel = try decoder.decode(decodingType, from: data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                completion(genericModel, nil)
            } catch let err {
                completion(nil, .jsonConversionFailure(description: "\(err.localizedDescription)"))
            }
        }
        return task
    }

    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {

        let task = decodingTask(with: request, decodingType: T.self) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    error != nil ? completion(.failure(.decodingTaskFailure(description: "\(String(describing: error))"))) : completion(.failure(.invalidData))
                    return
                }
                guard let value = decode(json) else {
                    completion(.failure(.jsonDecodingFailure)); return }
                completion(.success(value))
            }
        }
        task.resume()
    }

}
