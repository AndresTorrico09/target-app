//
//  LocationManager.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 09/09/2022.
//

import UIKit
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    private var locationManager: CLLocationManager = CLLocationManager()
    
    @Published var locationWasUpdated: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: // Location services are available.
            locationManager.startUpdatingLocation()
            break
        case .restricted, .denied: // Location services currently unavailable.
            break
        case .notDetermined: // Authorization not determined yet.
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationWasUpdated = location
        }
    }
}
