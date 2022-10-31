//
//  LocationManager.swift
//  WheterTest
//
//  Created by Ihor on 31.10.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol LocationService {
    func getCurrentLocation(complition: @escaping (LocationResult<Coordinates, UIAlertController>) -> Void)
}

class LocationManager: NSObject, LocationService {
    
    private var regionIsSet = false
    private var region: MKCoordinateRegion?
    private var locationManager = CLLocationManager()
    
    private var complition: ((LocationResult<Coordinates, UIAlertController>) -> Void)?
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: private methods
    
    private func locationAutorisation() {
        
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            DispatchQueue.main.async { [weak self] in
                self?.locationManager.requestWhenInUseAuthorization()
            }
            
        case .restricted:
            break
        case .denied:
            showAlertGetLocation(title: "location autorisation services are disabled",
                                 message: "would you like allow?",
                                 urlType: .getLocationAutorisation)
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    private func showAlertGetLocation(title: String,
                                      message: String?,
                                      urlType: AlertURL) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settings = UIAlertAction(title: "Allow", style: .default) { (alert) in
            guard let settingsUrl = urlType.getURL else { return }
            UIApplication.shared.open(settingsUrl, options: [:])
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .default)
        alert.addAction(settings)
        alert.addAction(cancel)
        
        complition?(.failure(alert))
    }
    
    enum AlertURL {
        case getLocationEnabled
        case getLocationAutorisation
        
        var getURL: URL? {
            switch self {
            case .getLocationEnabled:
                return URL(string: "App-Prefs:root=LOCATION_SERVICES")
            case .getLocationAutorisation:
                return URL(string: UIApplication.openSettingsURLString)
            }
        }
    }
    
    // MARK: LocationService protocol
    
    func getCurrentLocation(complition: @escaping (LocationResult<Coordinates, UIAlertController>) -> Void) {
       
        self.complition = complition
        locationAutorisation()
        // TODO get Location
    }
}

@frozen public enum LocationResult<Coordinates, Alert> where Alert : UIAlertController {

    /// A success, storing a `Success` value.
    case success(Coordinates)

    /// A failure, storing a `Failure` value.
    case failure(Alert)
    
}
extension LocationManager: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        
        if !regionIsSet {
            region = MKCoordinateRegion(center: location, latitudinalMeters: 1500, longitudinalMeters: 1500)
        
//        MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            //mapView.region = region
            regionIsSet = true
        }
    }
    
    @available(iOS 5.0, *)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationAutorisation()
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAutorisation()
    }
}
