import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
