//
//  HomeViewModel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 26/09/2022.
//

import Foundation
import CoreLocation

class HomeViewModel {
    
    // MARK: - Observed Properties
    @Published private var state: AuthViewModelState = .network(state: .idle)
    @Published var locationTapped: CLLocation?
    @Published var targets: [TargetElement]?
    
    func setLocationTapped(withLocation location: CLLocation) {
        self.locationTapped = location
    }
    
    func getTargets() {
        state = .network(state: .loading)
        TargetServices.getAll() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let targets):
                self.targets = targets
            case .failure(let error):
                self.state = .network(state: .error(error.localizedDescription))
            }
        }
    }
}
