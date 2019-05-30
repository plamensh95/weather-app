//
//  Injector.swift
//  WeatherApp
//
//  Created by Plamen Iliev on 30.05.19.
//  Copyright © 2019 Plamen SH. All rights reserved.
//

class Injector {
    
    class func injectRepositoryDependency() -> Repository {
        return Repository()
    }
    
    class func injectRemoteRepositoryDependency() -> RemoteRepository {
        return RemoteRepository()
    }
    
    class func injectAPIClientDependency() -> APIClient {
        return APIClient()
    }
}
