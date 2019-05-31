//
//  APIClient.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//
import Foundation

class APIClient {
    
    func getLocation(with woeId: Int, completion: @escaping (Result) -> ()) {

        guard let url = URL(string: "\(APIEndpoints.kLocation)/\(String(describing: woeId))") else {
            completion(.failure(.couldntReach))
            return
        }
        
        sendGetRequest(with: url, completion: { result in
            completion(result)
        })
    }
    
    // MARK: - API Requests
    private func sendGetRequest(with url: URL, completion: @escaping (Result) -> ()) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else {
                completion(.failure(.couldntReach))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200..<300 ~= httpResponse.statusCode {
                    completion(.success(safeData))
                } else {
                    completion(.failure(.couldntReach))
                }
            } else if let err = error {
                completion(.failure(.error(err)))
            } else {
                completion(.failure(.couldntReach))
            }
            
            }.resume()
    }
}
