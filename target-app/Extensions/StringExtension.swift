//
//  StringExtension.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 18/08/2022.
//

import Foundation

extension String {

  var localized: String {
    self.localize()
  }
    
  func localize(comment: String = "") -> String {
    NSLocalizedString(self, comment: comment)
  }
}
