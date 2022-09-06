//
//  AuthenticationServices.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

class AuthenticationServices {
    
    class func signup(
        name: String,
        email: String,
        password: String,
        passwordConfirmation: String,
        gender: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        BaseAPIClient.default.request(
            //TODO: fix firstName, lastName, username
            endpoint: AuthEndpoint.signUp(
                firstName: name,
                lastName: name,
                username: name,
                email: email,
                gender: gender,
                password: password,
                passwordConfirmation: passwordConfirmation
            )
        ) { (result: Result<UserResponse?, Error>, responseHeaders) in
            switch result {
            case .success(let userResponse):
                if let user = userResponse?.user {
                    completion(.success(user))
                } else {
                    //TODO: add error state
//                    completion(.failure(AuthError.userSessionInvalid))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
