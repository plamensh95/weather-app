//
//  Constants.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

struct APIEndpoints {
    static let kLocation = "https://www.metaweather.com/api/location"
    static let kStaticImageResourcePNG = "https://www.metaweather.com/static/img/weather/png"
    static let kStaticImageResourcePNG64 = "https://www.metaweather.com/static/img/weather/png/64"
}

struct Message {
    static let kReachServerError = "Couldn't reach server."
    static let kParseServerResponseError = "Couldn't parse server response."
}

struct ForecastDetails {
    static let kDetailsCellIdentifier = "cellReuseIdentifier_DetailTableViewCell"

    static let kAirPressure = "Air pressure"
    static let kWindSpeed = "Wind speed"
    static let kHumidity = "Humidity"
    static let kVisibility = "Visibility"
    static let kPredictability = "Predictability"
}


