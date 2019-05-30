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
    
    init(apiClient: APIClient = Injector.injectAPIClientDependency()) {
        self.apiClient = apiClient
    }
    
    func getLocations(with woeIds: [Int], completion: @escaping (Result) -> ()) {
        let parameters = buildLocationsParameters(for: woeIds)
        apiClient.getLocations(with: parameters) { result in
            switch result {
            case .success(let value):
                if let data = value as? Data {
                    let parsedLocations = self.parse(data, returning: Location.self)
                    completion(parsedLocations)
                } else {
                    completion(.failure(.couldntParse))
                }
            case .failure:
                completion(result)
            }
        }
    }
    
    private func buildLocationsParameters(for woeIds: [Int]) -> [String] {
        return woeIds.map { String(describing: $0) }
    }
    
    private func parse<T: Decodable>(_ data: Data, returning type: T.Type) -> Result {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let dictionary = jsonData as? [String: Any],
                let jsonDictionary = dictionary.jsonData() else {
                    return .failure(.couldntParse)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedObject = try decoder.decode(T.self, from: jsonDictionary)
            return .success(decodedObject)
            
        } catch (let err) {
            return (.failure(.error(err)))
        }
    }
}
