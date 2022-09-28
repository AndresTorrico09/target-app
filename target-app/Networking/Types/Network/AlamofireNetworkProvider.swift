//
//  AlamofireNetworkProvider.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation
import Alamofire

/// This should be the only place where the `Alamofire` dependency is imported
internal final class AlamofireNetworkProvider: NetworkProvider {

  func request(
    endpoint: Endpoint,
    completion: @escaping (Result<Network.Response, Error>) -> Void
  ) -> Cancellable {
    let headers = HTTPHeaders(endpoint.headers)

    return AF.request(
      endpoint.requestURL,
      method: endpoint.method.alamofireMethod,
      parameters: endpoint.parameters,
      encoding: getEncodingType(endpoint.encodingDestination),
      headers: headers
    )
    .validate()
    .response { [weak self] afResponse in
      switch afResponse.result {
      case.success:
        self?.handleAlamofireResponse(afResponse, completion: completion)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  private func handleAlamofireResponse(
    _ afResponse: AFDataResponse<Data?>,
    completion: @escaping (Result<Network.Response, Error>) -> Void
  ) {
    guard let response = afResponse.response else {
      completion(.failure(Network.ProviderError.noResponse))
      return
    }

    completion(.success(Network.Response(
      statusCode: response.statusCode,
      data: afResponse.data,
      headers: response.headers.dictionary
    )))
  }
    
   private func getEncodingType(
    _ encodingDestination: EncodingDestination
   ) -> ParameterEncoding {
       switch encodingDestination {
       case .queryString:
           return URLEncoding(destination: .queryString)
       case .methodDependent:
           return URLEncoding(destination: .methodDependent)
       case .httpBody:
           return URLEncoding(destination: .httpBody)
       case .jsonBody:
           return JSONEncoding.default
       }
   }
    
}

extension Network.HTTPMethod {
  var alamofireMethod: Alamofire.HTTPMethod {
    switch self {
    case .get:
      return .get
    case .post:
      return .post
    case .put:
      return .put
    case .delete:
      return .delete
    case .patch:
      return .patch
    }
  }
}

extension DataRequest: Cancellable {}
