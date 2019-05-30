//
//  APIClient.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//
import Foundation

class APIClient {
    
    func getLocations(with parameters: [String], completion: @escaping (Result) -> ()) {
        
        guard let firstLocationParameter = parameters.first,
            let url = buildURL(with: [firstLocationParameter]) else {
            completion(.failure(.noConnection))
            return
        }
        
        sendGetRequest(with: url, completion: { result in
            completion(result)
        })
    }
    
    private func sendGetRequest(with url: URL, completion: @escaping (Result) -> ()) {
        
        print("URL - \(url)")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else {
                completion(.failure(.noConnection))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200..<300 ~= httpResponse.statusCode {
                    completion(.success(safeData))
                } else {
                    completion(.failure(.noConnection))
                }
            } else if let err = error {
                completion(.failure(.error(err)))
            } else {
                completion(.failure(.noConnection))
            }
            
            }.resume()
    }
    
    private func buildURL(with parameters: [String]) -> URL? {
        var endpoint = APIEndpoints.kLocation
        
        parameters.forEach {
            endpoint += "/\($0)"
        }
        
        return URL(string: endpoint)
    }
}
