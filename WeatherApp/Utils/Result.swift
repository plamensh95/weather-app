//
//  Result.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

import Foundation

enum Result {
    case success(Any)
    case failure(CustomError)
}

enum CustomError: Error {
    case noConnection
    case couldntParse
    case error(Error)
    case other(String)
}

extension CustomError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .noConnection:
            return Message.kReachServerError
        case .couldntParse:
            return Message.kParseServerResponseError
        case .error(let error):
            return error.localizedDescription
        case .other(let message):
            return message
        }
    }
}
