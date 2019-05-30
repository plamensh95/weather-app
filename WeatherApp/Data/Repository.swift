//
//  Repository.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

class Repository {
    private let remoteRepository: RemoteRepository
    
    init(remoteRepository: RemoteRepository = Injector.injectRemoteRepositoryDependency()) {
        self.remoteRepository = remoteRepository
    }
    
    func getLocations(with woeIds: [Int], completion: @escaping (Result) -> ()) {
        return remoteRepository.getLocations(with: woeIds, completion: completion)
    }
}
