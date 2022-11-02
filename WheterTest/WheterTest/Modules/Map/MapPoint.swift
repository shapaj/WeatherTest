//
//  MapPoint.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import MapKit

class MapPoint: NSObject, MKAnnotation {
    var pointTitle: String
    var coordinate: CLLocationCoordinate2D
    
 
    init(coordinate: CLLocationCoordinate2D) {
        pointTitle = DefaultValues.Strings.selectedPoint
        self.coordinate = coordinate
    }
}
