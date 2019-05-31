//
//  RemoteRepository.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//
import Foundation

class RemoteRepository{
    private let apiClient: APIClient

    private let dispatchGroup = DispatchGroup()
    
    // MARK: - Initialization
    init(apiClient: APIClient = Injector.injectAPIClientDependency()) {
        self.apiClient = apiClient
    }
    
    // MARK: - API Calls
    func getLocation(with woeId: Int, completion: @escaping (Result) -> ()) {
        apiClient.getLocation(with: woeId) { result in
            switch result {
            case .success(let value):
                if let data = value as? Data, let parsedLocation = self.parse(data, returning: Location.self) {
                    completion(.success(parsedLocation))
                } else {
                    completion(.failure(.couldntParse))
                }
            case .failure:
                completion(result)
            }
        }
    }
    
    func getLocations(with woeIds: [Int], completion: @escaping (Result) -> ()) {
        var locations = [Location?]()
        
        woeIds.forEach { woeId in
            dispatchGroup.enter()
            apiClient.getLocation(with: woeId) { result in
                switch result {
                case .success(let value):
                    if let data = value as? Data {
                        let parsedLocation = self.parse(data, returning: Location.self)
                        locations.append(parsedLocation)
                    }
                case .failure:
                    locations.append(nil)
                }
                
                self.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .global(qos: .background)) {
            let successfullyParsedLocations = locations.compactMap{ $0 }
            if !successfullyParsedLocations.isEmpty {
                completion(.success(successfullyParsedLocations))
            } else {
                completion(.failure(.couldntParse))
            }
        }
    }
    
    // MARK: - Decode Data
    private func parse<T: Decodable>(_ data: Data, returning type: T.Type) -> T? {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let dictionary = jsonData as? [String: Any],
                let jsonDictionary = dictionary.jsonData() else {
                    return nil
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(T.self, from: jsonDictionary)
        } catch {
            return nil
        }
    }
}
