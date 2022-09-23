//
//  ViewControllerExtension.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 17/08/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func applyDefaultUIConfigs() {
        view.backgroundColor = .screenBackground
    }
    
    func applyBottomSheetUIConfigs() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 0, height: -2)
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.5
    }
    
}
