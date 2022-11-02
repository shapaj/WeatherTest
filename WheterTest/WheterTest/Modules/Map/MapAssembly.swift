//
//  MapAssembly.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import Foundation
import Swinject

struct MapAssembly {
    static func CreateModule(container: Container, handler: @escaping (Coordinates) -> Void) -> UIViewController {
        
        guard let viewController = MapView.createVC() as? MapView else {
            fatalError(" map view has nor been created")
        }
        
        viewController.handler = handler
        
        let presenter: MapPresenterProtocol = MapPresenter(view: viewController, container: container)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
