//
//  Location.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

enum WoeId: Int {
    case sofia = 839722
    case newYork = 2459115
    case tokyo = 1118370
    
    static let woeIdsOfInterest = [sofia, newYork, tokyo].map { $0.rawValue }
}

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
