//
//  NetworkState.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 30/08/2022.
//

import Foundation

enum NetworkState: Equatable {
  case idle, loading, error(_ error: String)
}
