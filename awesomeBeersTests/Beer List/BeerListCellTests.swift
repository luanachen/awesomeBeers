import Quick
import Nimble
import Nimble_Snapshots

@testable import awesomeBeers

class BeerListCellTests: QuickSpec {
    
    private var sut: BeerListCell!
    
    override func spec() {
        
        sut = BeerListCell()
        sut.frame = CGRect(x: 0, y: 0, width: 80, height: 90)
        
        // func name
        describe("#init") {
            context("when init with standard setup") {
                it("has a valid snapshot") {
                    let beer = Beer(beerId: 1,
                                    name: "Buzz",
                                    tagline: "A Real Bitter Experience.",
                                    description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
                                    imageUrl: "https://images.punkapi.com/v2/keg.png",
                                    abv: 4.5,
                                    ibu: 60)
                    self.sut.show(beer: beer)
                    
                    expect(self.sut).to(haveValidSnapshot())
                }
            }
        }
    }
    
}
