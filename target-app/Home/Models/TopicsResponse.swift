//
//  TopicsResponse.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 18/10/2022.
//

import Foundation

struct TopicsResponse: Codable {
    let topics: [TopicElement]
    
    func toDomain() -> [Topic] {
        return topics.map { $0.topic }
    }
}

struct TopicElement: Codable {
    let topic: Topic
}
