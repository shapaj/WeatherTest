//
//  MapViewProtocol.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import UIKit

protocol MapViewProtocol: UIViewController, ViewUpdateble, MapViewRouterProtocol {
}

protocol MapViewRouterProtocol {
    func dissmisView(coordinates: Coordinates?)
}

