//
//  HomeViewModel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 26/09/2022.
//

import Foundation
import CoreLocation

class HomeViewModel {
    
    private let targetServices: TargetServicesProtocol
    
    // MARK: - Observed Properties
    @Published private var state: AuthViewModelState = .network(state: .idle)
    @Published var targets: [Target] = []
    
    init(targetServices: TargetServicesProtocol) {
        self.targetServices = targetServices
    }
    
    func getTargets() {
        state = .network(state: .loading)
        targetServices.getAll() { [weak self] result in
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
