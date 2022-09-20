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
    private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?

    public func requestLocationAuthorization() {
        locationManager.delegate = self
        let currentStatus = locationManager.authorizationStatus

        // Only ask authorization if it was never asked before
        guard currentStatus == .notDetermined else { return }

        self.locationManager.requestAlwaysAuthorization()
    }
    // MARK: - CLLocationManagerDelegate
    public func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        self.requestLocationAuthorizationCallback?(status)
    }
}
