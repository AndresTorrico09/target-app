//
//  APIClient+Product.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

/// Definition for API clients used in the application.
/// i.e. `OtherAPIClient(networkProvider: URLSessionNetworkProvider())`
///
extension BaseAPIClient {
  static let `default` = BaseAPIClient(
    networkProvider: AlamofireNetworkProvider(),
    headersProvider: RailsAPIHeadersProvider(
      sessionHeadersProvider: SessionHeadersProvider()
    )
  )
}
