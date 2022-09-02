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
    
    // Regex fulfill RFC 5322 Internet Message format
    func isEmailFormatted() -> Bool {
        // swiftlint:disable line_length
        let emailRegex = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?"
        // swiftlint:enable line_length
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
