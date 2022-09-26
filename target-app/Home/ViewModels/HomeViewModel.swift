//
//  HomeViewModel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 26/09/2022.
//

import Foundation
import CoreLocation

class HomeViewModel {
    
    @Published var locationTapped: CLLocation?
    
    func setLocationTapped(withLocation location: CLLocation) {
        self.locationTapped = location
    }
}
