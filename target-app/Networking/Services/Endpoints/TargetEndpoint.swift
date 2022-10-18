//
//  TargetEndpoint.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 16/09/2022.
//

import Foundation

internal enum TargetEndpoint: RailsAPIEndpoint {
    
    case save(
        title: String,
        latitude: Double,
        longitude: Double,
        radius: Double,
        topicId: Int
    )
    case get
    case getTopics
    
    private static let targetsURL = "/targets/"
    private static let topicsURL = "/topics/"

    var path: String {
        switch self {
        case .save, .get:
            return TargetEndpoint.targetsURL
        case .getTopics:
            return TargetEndpoint.topicsURL
        }
    }
    
    var method: Network.HTTPMethod {
        switch self {
        case .save:
            return .post
        case .get, .getTopics:
            return .get
        }
    }
    
    var encodingDestination: EncodingDestination {
        switch self {
        case .save:
            return .jsonBody
        case .get, .getTopics:
            return .methodDependent
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .save(
            let title,
            let latitude,
            let longitude,
            let radius,
            let topicId
        ):
            let parameters = [
                "title": title,
                "latitude": latitude,
                "longitude": longitude,
                "radius": radius,
                "topic_id": topicId
            ] as [String : Any]
            return ["target": parameters]
        case .get:
            return [:]
        case .getTopics:
            return [:]
        }
    }
}

