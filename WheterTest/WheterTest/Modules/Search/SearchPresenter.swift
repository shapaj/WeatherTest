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
    func serchStringChanged(serchString: String?)
    func didSelectRowAt(indexPath: IndexPath)
}

class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var container: Container
    var currentPin: Coordinates?
    var networkService: NetworkService?
    var dataModel: [GeoCityModel] = []
    
    init(view: SearchViewProtocol, container: Container) {
        self.view = view
        self.container = container
        self.networkService = container.resolve(NetworkService.self)
    }
    
    func serchStringChanged(serchString: String?) {
        guard let serchString = serchString,
              !serchString.isEmpty else {
                  DispatchQueue.main.async { [weak self] in
                      self?.dataModel = []
                      self?.view?.updateViewInterface([])
                  }
                  return
              }
        
        networkService?.getCityByName(name: serchString) { [weak self] result in
            
            switch result {
            case .success(let cites):
                self?.dataModel = cites
                let viewModel = cites.compactMap { SearchResultViewModel(model: $0) }
                DispatchQueue.main.async {
                    self?.view?.updateViewInterface(viewModel)
                }
            case .failure(let error):
                self?.view?.presentAlert(message: error.localizedDescription)
            }
        }
    }
    
    
    func cancelButtonTaped() {
        view?.dissmisView(coordinates: nil)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        view?.dissmisView(coordinates: dataModel[indexPath.row].coordinates)
    }
}
