//
//  TargetServices.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 16/09/2022.
//

import Foundation

protocol TargetServicesProtocol {
    func save(
        title: String,
        latitude: Double,
        longitude: Double,
        radius: Double,
        topicId: Int,
        completion: @escaping (Result<TargetResponse, Error>) -> Void
    )
    
    func getAll(completion: @escaping (Result<[Target], Error>) -> Void)
    
    func getTopics(completion: @escaping (Result<[Topic], Error>) -> Void)
}

final class TargetServices: TargetServicesProtocol {

    let apiClient: APIClient
    
    init(apiClient: APIClient = BaseAPIClient.default) {
        self.apiClient = apiClient
    }
    
    enum ValidationError: Error {
      case nullResponse
    }
    
    func save(
        title: String,
        latitude: Double,
        longitude: Double,
        radius: Double,
        topicId: Int,
        completion: @escaping (Result<TargetResponse, Error>) -> Void
    ) {
        apiClient.request(
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
                if let response = targetResponse {
                    completion(.success(response))
                } else {
                    completion(.failure(ValidationError.nullResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAll(
        completion: @escaping (Result<[Target], Error>) -> Void
    ) {
        apiClient.request(
            endpoint: TargetEndpoint.get
        ) { (result: Result<TargetsResponse?, Error>, responseHeaders) in
            switch result {
            case .success(let targetsResponse):
                if let targetsResponse = targetsResponse {
                    completion(.success(targetsResponse.toDomain()))
                } else {
                    completion(.failure(ValidationError.nullResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTopics(completion: @escaping (Result<[Topic], Error>) -> Void) {
        apiClient.request(
            endpoint: TargetEndpoint.getTopics
        ) { (result: Result<TopicsResponse?, Error>, responseHeaders) in
            switch result {
            case .success(let topicsResponse):
                if let topicsResponse = topicsResponse {
                    completion(.success(topicsResponse.toDomain()))
                } else {
                    completion(.failure(ValidationError.nullResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
