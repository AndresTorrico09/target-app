//
//  DecodingConfiguration.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

internal struct DecodingConfiguration {
  
  static let `default` = DecodingConfiguration()
  
  let dateStrategy: JSONDecoder.DateDecodingStrategy
  let keyStrategy: JSONDecoder.KeyDecodingStrategy
  let dataStrategy: JSONDecoder.DataDecodingStrategy
  
  init(
    dateStrategy: JSONDecoder.DateDecodingStrategy = .iso8601,
    keyStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
    dataStrategy: JSONDecoder.DataDecodingStrategy = .base64
  ) {
    self.dateStrategy = dateStrategy
    self.keyStrategy = keyStrategy
    self.dataStrategy = dataStrategy
  }
}
