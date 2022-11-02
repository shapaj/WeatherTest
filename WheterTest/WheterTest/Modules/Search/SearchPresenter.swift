//
//  SearchPresenter.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import Foundation
import Swinject

protocol SearchPresenterProtocol: LifeCycleProtocol {
    func cancelButtonTaped()
}

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var container: Container
    var currentPin: Coordinates?
    var networkService: NetworkService?

    init(view: SearchViewProtocol, container: Container) {
        self.view = view
        self.container = container
        self.networkService = container.resolve(NetworkService.self)
    }
    
    func cancelButtonTaped() {
        view?.dissmisView(coordinates: nil)
    }
}
