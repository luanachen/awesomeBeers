import Quick
import Nimble
import Nimble_Snapshots

@testable import awesomeBeers

class DetailViewTests: QuickSpec {
    
    private var sut: DetailView!
    
    override func spec() {
        
        sut = DetailView()
        sut.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
        
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
                    let viewModel = BeerDetailViewModel(beer: beer)
                    self.sut.show(viewModel: viewModel)
                    
                    expect(self.sut).to(haveValidSnapshot())
                }
            }
        }
    }
    
}
