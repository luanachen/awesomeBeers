//
//  BeerListViewModel.swift
//  awesomeBeers
//
//  Created by Luana Chen on 04/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BeerListViewModel {

    weak var viewModelCoordinatorDelegate: BeerListViewModelCoordinatorDelegate?
    weak var viewDelegate: BeerListViewModelDelegate?

    let bag = DisposeBag()

    private var beers = BehaviorRelay<[BeerElement]>(value: [])

    private var errorMessage = BehaviorRelay<String>(value: "")

    lazy var myBeers: Observable<[BeerElement]> = {
        return beers.asObservable()
    }()

    lazy var myError: Observable<String> = {
        return errorMessage.asObservable()
    }()

    var selectedBeer: BeerElement!

    init(delegate: BeerListViewModelCoordinatorDelegate) {
        self.viewModelCoordinatorDelegate = delegate
    }

    func loadBeers() {

        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
//            beers = MockLoader().loadFile()
        }
        #endif

        self.viewDelegate?.showLoadingIndicator(isLoading: true)

        Facade.shared.dataProvider.beerSession.getAllBeers().subscribe(onNext: { (beers) in
            self.viewDelegate?.didLoad(success: true)
            self.beers.accept(beers)
        }, onError: { (error) in
            self.viewDelegate?.didLoad(success: false)
            self.errorMessage.accept(error.localizedDescription)
        })
        .disposed(by: bag)
    }

    func getNumberOfItems() -> Int {
        return beers.value.count
    }

    func getBeer(for row: Int) -> Observable<BeerElement> {
        return Observable.create({  observer -> Disposable in
            observer.onNext(self.beers.value[row])
            return Disposables.create()
        })
    }

    func didSelectRow(_ row: Int) {
        self.selectedBeer = beers.value[row]
        viewModelCoordinatorDelegate?.didSelect(beer: selectedBeer)
    }

    func getErrorMessage() -> String {
        return errorMessage.value
    }

}
