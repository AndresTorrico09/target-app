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
    
    private static let targetsURL = "/targets/"
    
    var path: String {
        switch self {
        case .save:
            return TargetEndpoint.targetsURL
        }
    }
    
    var method: Network.HTTPMethod {
        switch self {
        case .save:
            return .post
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
        }
    }
}
