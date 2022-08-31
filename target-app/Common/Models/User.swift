//
//  User.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
    var gender: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case password
        case passwordConfirmation = "password_confirmation"
        case gender
    }
}
