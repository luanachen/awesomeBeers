import Foundation

enum HTTPHeader {

    case contentType(String)
    case accept(String)
    case authorization(String)

    var header: (field: String, value: String) {

        switch self {
        case .contentType(let value): return (field: "Content-Type", value: value)
        case .accept(let value): return (field: "Accept", value: value)
        case .authorization(let value): return (field: "Authorization", value: value)
        }
    }
}
