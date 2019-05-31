//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

class LocationsViewModel {
    private let repository: Repository
    
    private var locations = [Location]() {
        didSet {
            updateUI?()
        }
    }
    
    var updateUI: (() -> ())?
    var displayErrorMessage: ((String) -> ())?
    
    init(repository: Repository = Injector.injectRepositoryDependency()) {
        self.repository = repository
        
        repository.getLocations(with: WoeId.woeIdsOfInterest) { result in
            switch result {
            case .success(let value):
                if let fetchedLocations = value as? [Location] {
                    self.locations = fetchedLocations
                }
            case .failure(let error):
                self.displayErrorMessage?(error.localizedDescription)
            }
        }
    }
}

// MARK: - Table View Methods
extension LocationsViewModel {
    func numberOfRows(inSection section: Int) -> Int {
        return locations.count
    }
    
    func location(at index: Int) -> Location? {
        guard index < locations.count else { return nil }
        return locations[index]
    }
    
    func forecastsForLocation(at index: Int) -> [Forecast]? {
        guard index < locations.count else { return nil }
        return locations[index].consolidatedWeather
    }
}
