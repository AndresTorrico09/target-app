//
//  UILabel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 18/08/2022.
//

import Foundation
import UIKit

enum LabelStyle {
    case primary (
        text: String = "",
        textColor: UIColor = .mainTitle,
        backgroundColor: UIColor = .clear,
        numberOfLines: Int = 0,
        textAlignment: NSTextAlignment = .center,
        fontSize: CGFloat = 25
    )
    case secondary (
        text: String = "",
        textColor: UIColor = .mainTitle,
        backgroundColor: UIColor = .clear,
        numberOfLines: Int = 0,
        textAlignment: NSTextAlignment = .center,
        fontSize: CGFloat = 17,
        isBold: Bool = true
    )
    case error (
        text: String = "",
        textColor: UIColor = .labelError,
        backgroundColor: UIColor = .clear,
        numberOfLines: Int = 0,
        textAlignment: NSTextAlignment = .center,
        fontSize: CGFloat = 14
    )
}

extension UILabel {
    
    convenience init(style: LabelStyle) {
        self.init()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switch style {
        case .primary(let text, let textColor, let backgroundColor, let numberOfLines, let textAlignment, let fontSize):
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.numberOfLines = numberOfLines
            self.textAlignment = textAlignment
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
        case .secondary(let text, let textColor, let backgroundColor, let numberOfLines, let textAlignment, let fontSize, let isBold):
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.numberOfLines = numberOfLines
            self.textAlignment = textAlignment
            let font: UIFont = {
                if isBold == true {
                    return UIFont.boldSystemFont(ofSize: fontSize)
                } else {
                    return self.font.withSize(fontSize)
                }
            }()
            self.font = font
        case .error(text: let text, textColor: let textColor, backgroundColor: let backgroundColor, numberOfLines: let numberOfLines, textAlignment: let textAlignment, fontSize: let fontSize):
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.numberOfLines = numberOfLines
            self.textAlignment = textAlignment
            self.font = self.font.withSize(fontSize)
            self.isHidden = true
        }
    }
}
