//
//  Cancellable.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

/// Defines a cancellable work.
internal protocol Cancellable {
  func cancel() -> Self
}
