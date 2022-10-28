//
//  HomeView.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import UIKit

final class HomeView: BaseViewController, HomeViewProtocol {
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
    
}
