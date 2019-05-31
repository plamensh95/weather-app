//
//  Location.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

struct Location: Codable {
    let woeid: Int
    let locationType: String
    let title: String
    let time: String
    let timezone: String
    let timezoneName: String
    let parent: ParentLocation
    let consolidatedWeather: [Forecast]
}
