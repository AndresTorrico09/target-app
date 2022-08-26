//
//  ButtonExtension.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 18/08/2022.
//

import Foundation
import UIKit

enum ButtonStyle {
    case primary (
        color: UIColor = .buttonBackground,
        title: String = "",
        titleColor: UIColor = .white,
        cornerRadius: CGFloat = UI.Button.cornerRadius,
        height: CGFloat = UI.Button.height,
        target: Any? = nil,
        action: Selector? = nil
    )
    case secondary (
        color: UIColor = .white,
        title: String = "",
        titleColor: UIColor = .black,
        cornerRadius: CGFloat = UI.Button.cornerRadius,
        height: CGFloat = UI.Button.height,
        target: Any? = nil,
        action: Selector? = nil
    )
}

extension UIButton {
    
    convenience init(
        style: ButtonStyle,
        tapHandler: (target: Any, action: Selector)?
    ) {
        self.init()
        
        switch style {
        case .primary(let color, let title, let titleColor, let cornerRadius, let height, let target, let action):
            translatesAutoresizingMaskIntoConstraints = false
            setTitle(title, for: .normal)
            setTitleColor(titleColor, for: .normal)
            backgroundColor = color
            setRoundBorders(cornerRadius)
            heightAnchor.constraint(equalToConstant: height).isActive = true
            if let action = action {
                addTarget(target, action: action, for: .touchUpInside)
            }
        case .secondary(let color, let title, let titleColor, let cornerRadius, let height, let target, let action):
            translatesAutoresizingMaskIntoConstraints = false
            setTitle(title, for: .normal)
            setTitleColor(titleColor, for: .normal)
            backgroundColor = color
            setRoundBorders(cornerRadius)
            heightAnchor.constraint(equalToConstant: height).isActive = true
            if let action = action {
                addTarget(target, action: action, for: .touchUpInside)
            }
        }
    }
}
