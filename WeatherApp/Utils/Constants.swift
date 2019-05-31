//
//  Constants.swift
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

struct APIEndpoints {
    static let kLocation = "https://www.metaweather.com/api/location"
    static let kStaticImageResourcePNG = "https://www.metaweather.com/static/img/weather/png"
    static let kStaticImageResourcePNG64 = "https://www.metaweather.com/static/img/weather/png/64"
}

struct Title {
    static let kOK = "OK"
    static let kGO = "GO"
    static let kCancel = "Cancel"
    static let kErrorOccurred = "An error occurred"
    static let kAddLocation = "Add Location"
}

struct Message {
    static let kReachServerError = "Couldn't reach server."
    static let kParseServerResponseError = "Couldn't parse server response."
    static let kAddLocation = "You can add location by entering it's corresponding WoeId."
    static let kEnterWoeId = "Enter WoeId here..."
    static let kWrongWoeId = "The WoeId you entered is invalid."
    static let kNotFoundWoeId = "Couldn't find a location matching this WoeId"
}

struct ForecastDetails {
    static let kDetailsCellIdentifier = "cellReuseIdentifier_DetailTableViewCell"

    static let kAirPressure = "Air pressure"
    static let kWindSpeed = "Wind speed"
    static let kHumidity = "Humidity"
    static let kVisibility = "Visibility"
    static let kPredictability = "Predictability"
}


