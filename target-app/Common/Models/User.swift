//
//  User.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

struct User: Codable {
    let id: Int?
    let firstName: String
    let lastName: String
    let fullName: String?
    let name: String
    let username: String
    let email: String
    let gender: String
    let password: String?
    let passwordConfirmation: String?
    let avatar: Avatar
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case name
        case username
        case email
        case gender
        case password
        case passwordConfirmation = "password_confirmation"
        case avatar
    }
    
    struct Avatar: Codable {
        var originalUrl: String?
        var normalUrl: String?
        var smallThumbUrl: String?
    
        private enum CodingKeys: String, CodingKey {
            case originalUrl = "original_url"
            case normalUrl = "normal_url"
            case smallThumbUrl = "small_thumb_url"
        }
    }
}
