//
//  UserDefaults+Extensions.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 31.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//
import Foundation

extension UserDefaults {
    
    private enum UserDefaultsKeys: String {
        case woeIds
    }
    
    class func getWoeIds() -> [Int] {
        guard let woeString = standard.string(forKey: UserDefaultsKeys.woeIds.rawValue) else { return [] }
        
        let woeIds = woeString.components(separatedBy: ",")
        return woeIds.compactMap { Int($0) }
    }
    
    class func appendWoeIds(_ newWoeIds: [Int]) {
        guard !newWoeIds.isEmpty else { return }
        
        var woeIds = getWoeIds()
        woeIds.append(contentsOf: newWoeIds)
        
        let woeString = woeIds.map { String(describing: $0) }.joined(separator: ",")
        standard.setValue(woeString, forKey: UserDefaultsKeys.woeIds.rawValue)
    }
    
    class func populateInitialWoeIds() {
        let woeString = standard.string(forKey: UserDefaultsKeys.woeIds.rawValue)
        if woeString == nil {
            appendWoeIds(WoeId.woeIdsOfInterest)
        }
    }
}
