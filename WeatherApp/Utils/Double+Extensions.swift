//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

extension Double {
    func formattedString() -> String {
        return String(format: "%.2f", self)
    }
}
