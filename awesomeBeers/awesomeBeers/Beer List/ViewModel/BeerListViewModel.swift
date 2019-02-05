//
//  BeerListViewModel.swift
//  awesomeBeers
//
//  Created by Luana Chen on 04/02/19.
//  Copyright © 2019 Luana Chen. All rights reserved.
//

import Foundation

class BeerListViewModel {
    
    weak var delegate: BeerListViewModelDelegate?
    
    private var beers: [BeerElement]!
    
    private var errorMessage: String!
    
    var selectedBeer: BeerElement!
    
    func loadBeers() {
        
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            beers = MockLoader().loadFile()
        }
        #endif
        
        self.delegate?.showLoadingIndicator(isLoading: true)
        
        Facade.shared.dataProvider.beerSession.getAllBeers { result in
            switch result {
            case .success(let beers):
                guard let beers = beers else { return }
                self.beers = beers
                self.delegate?.didLoad(success: true)
                self.delegate?.showLoadingIndicator(isLoading: false)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.delegate?.didLoad(success: false)
                self.delegate?.showLoadingIndicator(isLoading: false)
                print("the error \(error)")
            }
        }
    }
    
    func getNumberOfItems() -> Int? {
        return beers != nil ? beers.count : 0
    }
    
    func getBeer(for row: Int) -> BeerElement?  {
        guard let beers = beers else { return nil }
        return beers[row]
    }
    
    func setSelectedBeer(beer: BeerElement) {
        self.selectedBeer = beer
    }
    
    func getErrorMessage() -> String {
        return errorMessage
    }
    
}
