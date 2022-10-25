//
//  ConversationsServices.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 25/10/2022.
//

import Foundation

protocol ConversationsServicesProtocol {
    func getAll(completion: @escaping (Result<[Match], Error>) -> Void)
}

final class ConversationsServices: ConversationsServicesProtocol {
    
    let apiClient: APIClient
    
    init(apiClient: APIClient = BaseAPIClient.default) {
        self.apiClient = apiClient
    }
    
    enum ValidationError: Error {
        case nullResponse
    }
    
    func getAll(completion: @escaping (Result<[Match], Error>) -> Void) {
        apiClient.request(
            endpoint: ConversationsEndpoint.getAll
        ) { (result: Result<MatchResponse?, Error>, responseHeaders) in
            switch result {
            case .success(let matchesResponse):
                if let matchesResponse = matchesResponse {
                    completion(.success(matchesResponse.matches))
                } else {
                    completion(.failure(ValidationError.nullResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
