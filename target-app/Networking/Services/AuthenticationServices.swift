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
            endpoint: AuthEndpoint.signUp(
                name: name,
                email: email,
                password: password,
                passwordConfirmation: passwordConfirmation,
                gender: gender
            )
        ) { (result: Result<User?, Error>, responseHeaders) in
            switch result {
            case .success(let user):
                if let u = user {
                    completion(.success(u))
                } else {
//                    completion(.failure(AuthError.userSessionInvalid))
                }
//                if saveUserSession(user, headers: responseHeaders), let user = user {
//                    completion(.success(user))
//                } else {
//                    completion(.failure(AuthError.userSessionInvalid))
//                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    fileprivate class func saveUserSession(
//      _ user: User?,
//      headers: [String: String]
//    ) -> Bool {
//      UserDataManager.currentUser = user
//      SessionManager.currentSession = Session(headers: headers)
//
//      return UserDataManager.currentUser != nil && SessionManager.validSession
//    }
}
