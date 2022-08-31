//
//  HTTPHeader.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

internal enum HTTPHeader: String {
  case uid
  case client
  case expiry
  case token = "access-token"
  case accept = "Accept"
  case contentType = "Content-Type"
}
