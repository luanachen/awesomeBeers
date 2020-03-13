import Foundation

class MockLoader {

    func loadFile() -> [Beer]? {
        var beers = [Beer]()
        guard let url = Bundle.main.url(forResource: "beerList", withExtension: "json") else { return nil}
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let beerData = try decoder.decode([Beer].self, from: jsonData)
            beers = beerData
        } catch {
            fatalError("Couldn't load json file")
        }
        return beers
    }
}
