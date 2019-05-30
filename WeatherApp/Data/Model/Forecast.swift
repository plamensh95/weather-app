//
//  Forecast.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

struct Forecast: Codable {
    let id: Int
    let minTemp: Double
    let maxTemp: Double
    let theTemp: Double
    let airPressure: Double
    let windSpeed: Double
    let humidity: Double
    let visibility: Double
    let predictability: Double
    let weatherStateName: String
    let weatherStateAbbr: String
}
