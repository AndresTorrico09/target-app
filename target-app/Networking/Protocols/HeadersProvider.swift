//
//  HeadersProvider.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

internal protocol HeadersProvider {
  var requestHeaders: [String: String] { get }
}
