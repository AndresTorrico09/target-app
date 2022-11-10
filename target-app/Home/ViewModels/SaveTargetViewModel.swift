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
    @Published var targetResponse: TargetResponse?
    
    // MARK: - Publishers
    var statePublisher: Published<AuthViewModelState>.Publisher { $state }
    
    private var title: String = ""
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var radius: Double = 0.0
    private var topicId: Int = 0
    
    private var location: CLLocation
    
    var userMatched: ((MatchedUser) -> Void)?

    init(
        location: CLLocation,
        targetServices: TargetServicesProtocol,
        userMatched: @escaping ((MatchedUser) -> Void )
    ) {
        self.location = location
        self.targetServices = targetServices
        self.userMatched = userMatched
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
            case .success(let targetResponse):
                self.targetResponse = targetResponse
                //TODO: remove mock
//                targetResponse.matchedUser.map{ _ in
//                    self.userMatched?(
//                        MatchedUser(id: 100, email: "email.com", firstName: "name", lastName: "last", fullName: "full", username: "user", gender: "gender", avatar: Avatar(originalURL: "nil", normalURL: "nil", smallThumbURL: "nil"))
//                    )
//                }
                self.userMatched?(
                    MatchedUser(id: 100, email: "email.com", firstName: "name", lastName: "last", name: "full", username: "user", gender: "gender", avatar: Avatar(originalURL: "nil", normalURL: "nil", smallThumbURL: "nil"))
                )
            case .failure(let error):
                self.state = .network(state: .error(error.localizedDescription))
            }
        }
    }
    
    func getTopics() {
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
        if let radius = Double(radius) {
            self.radius = radius
        }
    }
    
    func setTopicId(topicName: String) {
        //TODO: fix receive ID instead label string
        if let id = topics.first(where: { $0.label == topicName } )?.id {
            self.topicId = id
        }
    }
}
