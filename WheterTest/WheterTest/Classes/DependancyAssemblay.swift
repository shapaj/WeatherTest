//
//  DependancyAssemblay.swift
//  WheterTest
//
//  Created by Ihor on 31.10.2022.
//

import Foundation
import Swinject

struct DependancyAssemblay {
    
    static func getBaseContainer() -> Container {
        let container = Container()
        registerNetworkService(container: container)
        registerDateManager(container: container)
        registerLocationManager(container: container)
        registerNetworkManager(container: container)
        
        return container
    }
    
    static func registerNetworkService(container: Container) {
        container.register(NetworkService.self, factory: { resolver in
            return OWMNetworkService(container: container)
        })
    }
    
    static func registerNetworkManager(container: Container) {
        container.register(NetworkManager.self, factory: { resolver in
            return NetworkManager()
        })
    }
    
    static func registerDateManager(container: Container) {
        container.register(DateService.self, factory: { resolver in
            return DateManager()
        })
    }
    
    static func registerLocationManager(container: Container) {
        container.register(LocationService.self, factory: { resolver in
            return LocationManager()
        })
    }
}
