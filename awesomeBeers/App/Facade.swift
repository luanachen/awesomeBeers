import Foundation

class Facade: NSObject {

    static var shared: Facade = Facade()
    var dataProvider: DataProvider!

    override init() {
        super.init()
        self.dataProvider = DataProvider()
    }
}
