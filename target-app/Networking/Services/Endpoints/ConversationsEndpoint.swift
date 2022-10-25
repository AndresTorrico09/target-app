//
//  ConversationsEndpoint.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 25/10/2022.
//

import Foundation

internal enum ConversationsEndpoint: RailsAPIEndpoint {
    
    case getAll
    
    private static let matchesURL = "/match_conversations/"

    var path: String {
        switch self {
        case .getAll:
            return ConversationsEndpoint.matchesURL
        }
    }
    
    var method: Network.HTTPMethod {
        switch self {
        case .getAll:
            return .get
        }
    }
    
    var encodingDestination: EncodingDestination {
        switch self {
        case .getAll:
            return .methodDependent
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getAll:
            return [:]
        }
    }
}

