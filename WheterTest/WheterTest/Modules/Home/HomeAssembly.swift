//
//  HomeAssembly.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation
import Swinject

struct HomeAssembly {
    
    static func createModule(container: Container) -> HomeView {
        let viewController = HomeView.createVC()
        
        let presenter: HomePresenterProtocol = HomePresenter(view: viewController, container: container)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
