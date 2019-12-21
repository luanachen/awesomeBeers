import Foundation

struct BeerResult: Decodable {
    let beer: [BeerElement]?
}

struct BeerElement: Decodable {
    let beerId: Int
    let name, tagline, description: String
    let imageUrl: String
    let abv: Double
    let ibu: Double?

    enum CodingKeys: String, CodingKey {
        case beerId = "id"
        case imageUrl = "image_url"
        case name, tagline, description, abv, ibu
    }
}

struct BeerParameter: Encodable {
    let name: String
}
