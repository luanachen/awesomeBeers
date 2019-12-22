import Foundation

protocol EndpointType {
    var base: String { get }
    var path: String { get }
}

extension EndpointType {
    var components: URLComponents {
        if var components = URLComponents(string: base) {
            components.path = path
            return components
        }
        fatalError("Fail to set components!")

    }

    var request: URLRequest {
        if let url = components.url {
            return URLRequest(url: url)
        }
        fatalError("Failed to set URL!")
    }

}
