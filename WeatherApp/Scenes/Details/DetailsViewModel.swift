//
//  ForecastDetailsViewModel.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

class DetailsViewModel {
    private var forecast: Forecast
    
    private var detailsArray = [String]()
    
    var updateUI: ((Forecast) -> ())?
    
    init(forecast: Forecast) {
        self.forecast = forecast
        detailsArray = buildDetailsArray(from: forecast)
    }
    
    func feedContent() {
        updateUI?(forecast)
    }
    
    private func buildDetailsArray(from forecast: Forecast) -> [String] {
        var array = [String]()
        array.append("\(ForecastDetails.kAirPressure): \(forecast.airPressure.formattedString())")
        array.append("\(ForecastDetails.kWindSpeed): \(forecast.windSpeed.formattedString())")
        array.append("\(ForecastDetails.kHumidity): \(forecast.humidity.formattedString())")
        array.append("\(ForecastDetails.kVisibility): \(forecast.visibility.formattedString())")
        array.append("\(ForecastDetails.kPredictability): \(forecast.predictability.formattedString())")
        return array
    }
}

// MARK: - Table View Methods
extension DetailsViewModel {
    func numberOfRows(inSection section: Int) -> Int {
        return detailsArray.count
    }
    
    func detail(at index: Int) -> String? {
        guard index < detailsArray.count else { return nil }
        return detailsArray[index]
    }
}

