import Foundation
import Quick
import Nimble
import Nimble_Snapshots
import KIF

@testable import awesomeBeers

class DefaultFlowTest: QuickSpec {
    override func spec() {
        
        describe("default flow behavior") {
            var coordinator: BeerListCoordinator!
            var navigationController: UINavigationController!
            var window: UIWindow!
            
            beforeEach {
                window = UIApplication.shared.keyWindow
                window.frame = CGRect(x:0, y:0, width: 320, height: 564)
                window.makeKeyAndVisible()
                
                navigationController = UINavigationController()
                window.rootViewController = navigationController
                coordinator = BeerListCoordinator(navigation: navigationController)
            }
            
            context("on select a cell") {
                it("it should show beer detail when a cell is selected") {
                    coordinator.start()
                    
                    expect(navigationController.visibleViewController).toEventually(beAKindOf(BeerListViewController.self))
                    expect(navigationController.visibleViewController).toEventually(recordSnapshot(named: "pre cell selected"))
                    
                    let indexPath = IndexPath(item: 1, section: 0)
                    self.tester().tapItem(at: indexPath, inCollectionViewWithAccessibilityIdentifier: "CollectionView")
                    self.tester().wait(forTimeInterval: 2)
                    
                    expect(navigationController.visibleViewController).toEventually(beAKindOf(BeerDetailViewController.self))
                    expect(navigationController.visibleViewController).toEventually(haveValidSnapshot(named: "cell selected"))
                }
            }
        }
    }
}
