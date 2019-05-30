//
//  ForecastsViewModel.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

class ForecastsViewModel {
    private var forecasts: [Forecast]
    
    init(forecasts: [Forecast]) {
        self.forecasts = forecasts
    }
}

// MARK: - Table View Methods
extension ForecastsViewModel {
    func numberOfRows(inSection section: Int) -> Int {
        return forecasts.count
    }
    
    func forecast(at index: Int) -> Forecast? {
        guard index < forecasts.count else { return nil }
        return forecasts[index]
    }
}
