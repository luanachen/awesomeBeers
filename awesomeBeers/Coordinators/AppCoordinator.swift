import UIKit

class AppCoordinator: CoordinatorProtocol {

    var window: UIWindow
    var beerListCoordinator: BeerListCoordinator?

    private let navigation: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = navigation
        beerListCoordinator = BeerListCoordinator(navigation: navigation)
        beerListCoordinator?.start()
    }
}
