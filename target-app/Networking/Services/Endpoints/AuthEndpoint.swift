//
//  AuthEndpoint.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

internal enum AuthEndpoint: RailsAPIEndpoint {
    
    case signIn(email: String, password: String)
    
    case signUp(
        firstName: String,
        lastName: String,
        username: String,
        email: String,
        gender: String,
        password: String,
        passwordConfirmation: String
    )
    
    private static let usersURL = "/users/"
    
    var path: String {
        switch self {
        case .signIn:
          return AuthEndpoint.usersURL + "sign_in"
        case .signUp:
            return AuthEndpoint.usersURL
        }
    }
    
    var method: Network.HTTPMethod {
        switch self {
        case .signUp, .signIn:
            return .post
        }
    }
    
    var encodingDestination: EncodingDestination {
        switch self {
        case .signUp, .signIn:
            return .jsonBody
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .signIn(let email, let password):
          return [
            "user": [
              "email": email,
              "password": password
            ]
          ]
        case .signUp(
            let firstName,
            let lastName,
            let username,
            let email,
            let gender,
            let password,
            let passwordConfirmation
        ):
            let parameters = [
                "first_name": firstName,
                "last_name": lastName,
                "username": username,
                "email": email,
                "gender": gender,
                "password": password,
                "password_confirmation": passwordConfirmation
            ]
            return ["user": parameters]
        }
    }
}
