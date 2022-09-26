//
//  SaveTargetViewModel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 16/09/2022.
//

import Foundation
import CoreLocation

class SaveTargetViewModel {
    
    // MARK: - Observed Properties
    @Published private var state: AuthViewModelState = .network(state: .idle)

    // MARK: - Publishers
    var statePublisher: Published<AuthViewModelState>.Publisher { $state }
    
    private var title: String = ""
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var radius: Double = 0.0
    private var topicId: Int = 0
    
    private var location: CLLocation
    
    init(location: CLLocation) {
        self.location = location
    }
    
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
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setLocationSelected() {
        self.latitude = self.location.coordinate.latitude
        self.longitude = self.location.coordinate.longitude
    }
    
    func setArea(radius: String) {
        self.radius = Double(radius)!
    }
    
    func setTopicId(topicId: String) {
        //TODO: get topic values from API
        let topic = {
            switch topicId {
            case "Football":
                return 1
            case "Pizza":
                return 2
            case "Dogs":
                return 3
            default:
                return 0
            }
        }()
        
        self.topicId = topic
    }
}
