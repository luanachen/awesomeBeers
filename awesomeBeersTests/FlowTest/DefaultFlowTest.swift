import Foundation
import Quick
import Nimble
import Nimble_Snapshots
import KIF

@testable import awesomeBeers

class DefaultFlowTest: QuickSpec {
    override func spec() {
        
        describe("default flow behavior") {
            var sut: BeerListViewController!
            var window: UIWindow!
            
            beforeEach {
                window = UIWindow(frame: CGRect(x:0, y:0, width: 320, height: 564))
                window.makeKeyAndVisible()
            }
            
            afterEach {
                UIView.setAnimationsEnabled(false)
                window.isHidden = true
                window = nil
            }
            
            context("on select a cell") {
                
                beforeEach {
                    sut = BeerListViewController()
                    window.rootViewController = sut
                }
                
                it("it shoud show beer detail when a cell is selected") {
                    expect(window).toEventually(recordSnapshot(named: "pre cell selected"))
                    
                    self.tester().tapView(withAccessibilityLabel: "BeerListCell")
                    expect(window).toEventually(recordSnapshot(named: "cell selected"))
                }
            }
        }
    }
}
