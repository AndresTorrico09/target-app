//
//  ViewExtension.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 17/08/2022.
//

import Foundation
import UIKit

extension UIView {
    // MARK: Constrains Helper
    
    func addSubviews(subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}
