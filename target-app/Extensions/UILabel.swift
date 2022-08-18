//
//  UILabel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 18/08/2022.
//

import Foundation
import UIKit

extension UILabel {
    
    static func titleLabel (
        text: String = "",
        textColor: UIColor = .mainTitle,
        backgroundColor: UIColor = .clear,
        numberOfLines: Int = 0,
        textAlignment: NSTextAlignment = .center,
        fontSize: CGFloat = 25
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        label.font = label.font.withSize(fontSize)
        
        return label
    }
}
