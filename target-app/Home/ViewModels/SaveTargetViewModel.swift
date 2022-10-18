//
//  SaveTargetViewModel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 16/09/2022.
//

import Foundation
import CoreLocation

class SaveTargetViewModel {
    
    private let targetServices: TargetServicesProtocol

    // MARK: - Observed Properties
    @Published private var state: AuthViewModelState = .network(state: .idle)
    @Published var topics: [Topic] = []

    // MARK: - Publishers
    var statePublisher: Published<AuthViewModelState>.Publisher { $state }
    
    private var title: String = ""
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var radius: Double = 0.0
    private var topicId: Int = 0
    
    private var location: CLLocation
    
    init(location: CLLocation, targetServices: TargetServicesProtocol) {
        self.location = location
        self.targetServices = targetServices
    }
    
    func saveTarget() {
        state = .network(state: .loading)
        targetServices.save(
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
    
    func getTopics() {
        state = .network(state: .loading)
        targetServices.getTopics() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let topics):
                self.topics = topics
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
        //TODO: fix receive ID instead label string
        var id: Int = 0
        self.topics.forEach { topic in
            if topic.label == topicId {
                id = topic.id
            }
        }
        self.topicId = id
    }
}
