import Foundation

enum APIError: Error {
    case invalidData
    case jsonDecodingFailure
    case responseUnsuccessful(description: String)
    case decodingTaskFailure(description: String)
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case postParametersEncodingFailure(description: String)

    var customDescription: String {
        switch self {
        case .requestFailed(let description): return "APIError - Request Failed -> \(description)"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful(let description): return "APIError - Response Unsuccessful status code -> \(description)"
        case .jsonDecodingFailure: return "APIError - JSON decoding Failure"
        case .jsonConversionFailure(let description): return "APIError - JSON Conversion Failure -> \(description)"
        case .decodingTaskFailure(let description): return "APIError - decodingtask failure with error -> \(description)"
        case .postParametersEncodingFailure(let description): return "APIError - post parameters failure -> \(description)"
        }
    }
}
