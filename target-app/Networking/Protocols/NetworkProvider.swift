//
//  NetworkProvider.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

/// Interface that provides an opportunity to define the HTTP
/// communication layer.
internal protocol NetworkProvider {

  /// Performs a HTTP request to the given `Endpoint`.
  /// - Parameters:
  ///   - endpoint: An object conforming to `Endpoint` providing the request information.
  ///   - completion: The closure executed after the request is completed.
  /// - Returns: A `Cancellable` request.
  func request(
    endpoint: Endpoint,
    completion: @escaping (Result<Network.Response, Error>) -> Void
  ) -> Cancellable

}
