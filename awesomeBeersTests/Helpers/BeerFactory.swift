struct BeerFactory {
    static func build() -> Beer {
        return Beer(beerId: 1,
                    name: "Buzz",
                    tagline: "A Real Bitter Experience.",
                    description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
                    imageUrl: "https://images.punkapi.com/v2/keg.png",
                    abv: 4.5,
                    ibu: 60)
    }
}
