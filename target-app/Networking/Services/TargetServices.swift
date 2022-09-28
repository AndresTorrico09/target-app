//
//  TargetServices.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 16/09/2022.
//

import Foundation

class TargetServices {
    
    enum AuthError: Error {
      case userSessionInvalid
    }
    
    class func save(
        title: String,
        latitude: Double,
        longitude: Double,
        radius: Double,
        topicId: Int,
        completion: @escaping (Result<Target, Error>) -> Void
    ) {
        BaseAPIClient.default.request(
            endpoint: TargetEndpoint.save(
                title: title,
                latitude: latitude,
                longitude: longitude,
                radius: radius,
                topicId: topicId
            )
        ) { (result: Result<TargetResponse?, Error>, responseHeaders) in
            switch result {
            case .success(let targetResponse):
                if let target = targetResponse?.target {
                    completion(.success(target))
                } else {
                    completion(.failure(AuthError.userSessionInvalid))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    class func get(
        completion: @escaping (Result<[TargetElement], Error>) -> Void
    ) {
        BaseAPIClient.default.request(
            endpoint: TargetEndpoint.get
        ) { (result: Result<GetTargetResponse?, Error>, responseHeaders) in
            switch result {
            case .success(let getTargetResponse):
                if let targets = getTargetResponse?.targets {
                    completion(.success(targets))
                } else {
                    completion(.failure(AuthError.userSessionInvalid))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
