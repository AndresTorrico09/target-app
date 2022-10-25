//
//  ChatsViewModel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 25/10/2022.
//

import Foundation
import CoreLocation

class ChatsViewModel {
    
    private let conversationsServices: ConversationsServicesProtocol
    
    // MARK: - Observed Properties
    @Published private var state: AuthViewModelState = .network(state: .idle)
    @Published var matches: [Match] = []
    
    init(conversationsServices: ConversationsServicesProtocol) {
        self.conversationsServices = conversationsServices
    }
    
    func getMatchConversations() {
        state = .network(state: .loading)
        conversationsServices.getAll() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let matches):
                self.matches = matches
            case .failure(let error):
                self.state = .network(state: .error(error.localizedDescription))
            }
        }
    }
}
