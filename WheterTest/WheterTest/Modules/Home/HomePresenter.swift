//
//  HomePresenter.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    
    var view: HomeViewProtocol?
//    var model:
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
    
}
