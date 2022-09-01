//
//  AuthEndpoint.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

internal enum AuthEndpoint: RailsAPIEndpoint {
    case signUp(
        firstName: String,
        lastName: String,
        username: String,
        email: String,
        gender: String,
        password: String,
        passwordConfirmation: String
    )
    
    private static let usersURL = "/users"
    
    var path: String {
        switch self {
        case .signUp:
            return AuthEndpoint.usersURL
        }
    }
    
    var method: Network.HTTPMethod {
        switch self {
        case .signUp:
            return .post
        }
    }
}
