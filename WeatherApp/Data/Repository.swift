//
//  Repository.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//
import Foundation

class Repository {
    private let remoteRepository: RemoteRepository
    
    init(remoteRepository: RemoteRepository = Injector.injectRemoteRepositoryDependency()) {
        self.remoteRepository = remoteRepository
    }
    
    func getLocations(completion: @escaping (Result) -> ()) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let safeSelf = self else { return }
            
            let woeIds = UserDefaults.getWoeIds()
            return safeSelf.remoteRepository.getLocations(with: woeIds, completion: completion)
        }
    }
    
    func getLocation(with woeId: Int, completion: @escaping (Result) -> ()) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            return self?.remoteRepository.getLocation(with: woeId) { result in
                switch result {
                case .success(_):
                    UserDefaults.appendWoeIds([woeId])
                case .failure(_):
                    break
                }
                completion(result)
            }
        }
    }
}
