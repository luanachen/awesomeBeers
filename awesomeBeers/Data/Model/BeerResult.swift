import Foundation

struct Beer: Decodable {
    let beerId: Int
    let name, tagline, description: String
    let imageUrl: String
    let abv: Double
    let ibu: Double?

    enum CodingKeys: String, CodingKey {
        case beerId = "id"
        case imageUrl = "imageUrl"
        case name, tagline, description, abv, ibu
    }
}

struct BeerParameter: Encodable {
    let name: String
}
