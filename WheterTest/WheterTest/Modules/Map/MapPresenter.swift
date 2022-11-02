//
//  MapPresenter.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import Foundation
import Swinject
import CoreLocation

class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var container: Container
    var currentPin: Coordinates?

    init(view: MapViewProtocol, container: Container) {
        self.view = view
        self.container = container
    }
    
    func cancelButtonPushed() {
        view?.dissmisView(coordinates: nil)
    }
    
    func newPinPicked(coordinates: Any) {
        view?.dissmisView(coordinates: currentPin)
    }

    func doneButtonPushed() {
        guard let currentPin = currentPin else { return }
        view?.dissmisView(coordinates: currentPin)
    }
    
    func mapViewTap(coordinates: CLLocationCoordinate2D) {
        currentPin = Coordinates(lon: coordinates.longitude,
                                lat: coordinates.latitude)
    }
}
