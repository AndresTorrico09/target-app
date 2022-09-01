//
//  User.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

struct User: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var gender: String
    var password: String
    var passwordConfirmation: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case email
        case gender
        case password
        case passwordConfirmation = "password_confirmation"
    }
}
