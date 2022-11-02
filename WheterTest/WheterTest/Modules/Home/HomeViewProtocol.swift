//
//  HomeViewProtocol.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import UIKit
import Swinject

protocol HomeViewProtocol: UIViewController, ViewUpdateble, HomeViewRouterProtocol {
    
}

protocol HomeViewRouterProtocol {
    func presentMap(container: Container, handler: @escaping (Coordinates) -> Void)
}
