//
//  MapPresenterProtocol.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import Foundation
import CoreLocation

protocol MapPresenterProtocol: LifeCycleProtocol {
    func doneButtonPushed()
    func cancelButtonPushed()
    func newPinPicked(coordinates: Any)
    func mapViewTap(coordinates: CLLocationCoordinate2D)
}
