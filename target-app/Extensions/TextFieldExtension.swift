//
//  TextFieldExtension.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 18/08/2022.
//

import UIKit

extension UITextField {
    
    convenience init(
        target: Any,
        selector: Selector? = nil,
        placeholder: String = "",
        backgroundColor: UIColor = .white,
        height: CGFloat = UI.TextField.height,
        borderStyle: BorderStyle = .line,
        isPassword: Bool = false
    ) {
        self.init()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let selector = selector {
            addTarget(target, action: selector, for: .editingChanged)
        }
        
        self.attributedPlaceholder = getPlaceholder(placeholder: placeholder)
        self.backgroundColor = backgroundColor
        self.borderStyle = borderStyle
        heightAnchor.constraint(equalToConstant: height).isActive = true
        isSecureTextEntry = isPassword
        self.textAlignment = .center
    }
    
    func getPlaceholder(placeholder: String) -> NSAttributedString {
        let fieldParagraphStyle = NSMutableParagraphStyle()
        fieldParagraphStyle.alignment = .center
        let passwordFieldPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.paragraphStyle: fieldParagraphStyle]
        )
        return passwordFieldPlaceholder
    }
}
