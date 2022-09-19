//
//  TargetResponse.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 16/09/2022.
//

import Foundation

// MARK: - Welcome
struct TargetResponse: Codable {
    let target: Target
    let matchConversation: MatchConversation
    let matchedUser: MatchedUser

    enum CodingKeys: String, CodingKey {
        case target
        case matchConversation = "match_conversation"
        case matchedUser = "matched_user"
    }
}
