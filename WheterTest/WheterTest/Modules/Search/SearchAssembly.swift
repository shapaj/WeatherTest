//
//  SearchAssembly.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import Foundation
import Swinject

struct SearchAssembly {
    static func CreateModule(container: Container, handler: @escaping (Coordinates) -> Void) -> UIViewController {
        
        guard let viewController = SearchView.createVC() as? SearchView else {
            fatalError(" Search view has nor been created")
        }
        
        viewController.handler = handler
        
        let presenter: SearchPresenterProtocol = SearchPresenter(view: viewController, container: container)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
