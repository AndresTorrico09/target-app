//
//  Match.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 19/10/2022.
//

import Foundation

struct Match: Codable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(matchID)
    }
    
    let matchID: Int
    let topicIcon: String
    let lastMessage: String?
    let unreadMessages: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case topicIcon = "topic_icon"
        case lastMessage = "last_message"
        case unreadMessages = "unread_messages"
        case user
    }
    
    //TODO: add placeholder when set image URL
    var userImageURL: String {
        user.avatar.smallThumbUrl ?? ""
    }
    
    var userFullName: String {
        user.fullName ?? ""
    }
}

extension Match: Equatable {
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.matchID == rhs.matchID
    }
}
