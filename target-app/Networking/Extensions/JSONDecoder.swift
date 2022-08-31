//
//  JSONDecoder.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 31/08/2022.
//

import Foundation

extension JSONDecoder {
  
  convenience init(decodingConfig: DecodingConfiguration) {
    self.init()
    
    dateDecodingStrategy = decodingConfig.dateStrategy
    keyDecodingStrategy = decodingConfig.keyStrategy
    dataDecodingStrategy = decodingConfig.dataStrategy
  }
  
}
