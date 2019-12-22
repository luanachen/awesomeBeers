import Foundation

protocol APIClient {
    
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type,
                                            completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
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
            
            let output = String(data: data, encoding: String.Encoding.utf8)
            print("output ", output as Any)
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let genericModel = try decoder.decode(decodingType, from: data)
                completion(genericModel, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error.localizedDescription)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void) {
        
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
