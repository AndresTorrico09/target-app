//
//  AuthEndpoint.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

internal enum AuthEndpoint: RailsAPIEndpoint {
    case signUp(
        name: String,
        email: String,
        password: String,
        passwordConfirmation: String,
        gender: String
    )
    
    private static let usersURL = "/api/v1/users"
    
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
