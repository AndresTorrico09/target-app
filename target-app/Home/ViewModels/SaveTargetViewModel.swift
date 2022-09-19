//
//  SaveTargetViewModel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 16/09/2022.
//

import Foundation

class SaveTargetViewModel {
    
    // MARK: - Observed Properties
    @Published private var state: AuthViewModelState = .network(state: .idle)

    // MARK: - Publishers
    var statePublisher: Published<AuthViewModelState>.Publisher { $state }
    
    //TODO: remove mock data
    private var title: String = "new target"
    private var latitude: Double = -94.5566
    private var longitude: Double = -94.5566
    private var radius: Double = 27384.4
    private var topicId: Int = 2
    
    func saveTarget() {
        state = .network(state: .loading)
        TargetServices.save(
            title: title,
            latitude: latitude,
            longitude: longitude,
            radius: radius,
            topicId: topicId
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.state = .loggedIn
                AppNavigator.shared.navigate(to: HomeRoutes.home, with: .changeRoot)
            case .failure(let error):
                self.state = .network(state: .error(error.localizedDescription))
            }
        }
    }
}
