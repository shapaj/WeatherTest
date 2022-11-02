//
//  MapView.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import Foundation
import UIKit
import MapKit

class MapView: BaseViewController, MapViewProtocol, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var presenter: MapPresenterProtocol!
    var handler: ((Coordinates) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad?()
        setupElements()

    }
    
    private func setupElements() {
        setupMapView()
    }
    
    private func setupMapView() {
        mapView.delegate = self
        addEvent()
    }
    
    private func addEvent() {
        let event = UILongPressGestureRecognizer(target: self, action: #selector(mapViewTap))
        event.minimumPressDuration = 0.25
        mapView.addGestureRecognizer(event)
        
    }
    
    @objc func mapViewTap(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self.mapView)
        let coordinates = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        let mapPoint = MapPoint(coordinate: coordinates)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(mapPoint)
        
        presenter.mapViewTap(coordinates: coordinates)
    }
    
    func updateViewInterface(_ viewModel: Any) {
        
    }
    
    @IBAction func cancelButtonPushed(_ sender: UIBarButtonItem) {
        presenter.cancelButtonPushed()
    }
    
    @IBAction func doneButtonPushed(_ sender: UIBarButtonItem) {
        presenter.doneButtonPushed()
    }
    
    func dissmisView(coordinates: Coordinates?) {
        if let coordinates = coordinates {
            handler?(coordinates)
        }
        dismiss(animated: true)
    }
}
