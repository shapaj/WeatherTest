//
//  HomeAssembly.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

struct HomeAssembly {
    
    static func createModule() -> HomeView {
        let viewController = HomeView.createVC()
        
        let presenter: HomePresenterProtocol = HomePresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
