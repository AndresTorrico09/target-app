//
//  Target.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 16/09/2022.
//

import Foundation

// MARK: - Target
struct Target: Codable {
    let id: Int
    let title: String
    let latitude, longitude, radius: Double
    let topic: Topic
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case latitude, longitude, radius
        case topic
    }
}

extension Target: Equatable {}

func ==(lhs: Target, rhs: Target) -> Bool {
    lhs.id == rhs.id
}

// MARK: - MatchConversation
struct MatchConversation: Codable {
    let id, topicID: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case topicID = "topic_id"
    }
}

// MARK: - MatchedUser
struct MatchedUser: Codable {
    let id: Int
    let email, firstName, lastName, name, username, gender: String
    let avatar: Avatar

    private enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case name, username, gender, avatar
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let originalURL, normalURL, smallThumbURL: String?

    private enum CodingKeys: String, CodingKey {
        case originalURL = "original_url"
        case normalURL = "normal_url"
        case smallThumbURL = "small_thumb_url"
    }
}

// MARK: - Topic
struct Topic: Codable {
    let id: Int
    let icon, label: String

    private enum CodingKeys: String, CodingKey {
        case id
        case icon, label
    }
}
