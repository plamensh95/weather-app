//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

class LocationsViewModel {
    private let repository: Repository
    
    private var locations = [Location]()
    
    init(repository: Repository = Injector.injectRepositoryDependency()) {
        self.repository = repository
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
