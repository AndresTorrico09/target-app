//
//  ButtonExtension.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 18/08/2022.
//

import Foundation
import UIKit

extension UIButton {
    
    static func primaryButton(
        color: UIColor = .buttonBackground,
        title: String = "",
        titleColor: UIColor = .white,
        cornerRadius: CGFloat = UI.Button.cornerRadius,
        height: CGFloat = UI.Button.height,
        target: Any? = nil,
        action: Selector? = nil
    ) -> UIButton {
        let button = UIButton()
        button.setup(
            color: color,
            title: title,
            titleColor: titleColor,
            cornerRadius: cornerRadius,
            height: height
        )
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        return button
    }
    
    static func secondaryButton(
        color: UIColor = .white,
        title: String = "",
        titleColor: UIColor = .black,
        cornerRadius: CGFloat = UI.Button.cornerRadius,
        height: CGFloat = UI.Button.height,
        target: Any? = nil,
        action: Selector? = nil
    ) -> UIButton {
        let button = UIButton()
        button.setup(
            color: color,
            title: title,
            titleColor: titleColor,
            cornerRadius: cornerRadius,
            height: height
        )
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        return button
    }
    
    private func setup(
        color: UIColor = .buttonBackground,
        title: String = "",
        titleColor: UIColor = .white,
        cornerRadius: CGFloat = UI.Button.cornerRadius,
        height: CGFloat = UI.Button.height
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
        setRoundBorders(cornerRadius)
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
