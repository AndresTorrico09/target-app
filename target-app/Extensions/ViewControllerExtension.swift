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
    
    func setupNavigationBar(
      title: String,
      leftButton: UIBarButtonItem? = nil,
      rightButton: UIBarButtonItem? = nil,
      tintColor: UIColor = .black
    ) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.titleView = UILabel(style: .secondary(text: title))
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem?.tintColor = tintColor
        
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.rightBarButtonItem?.tintColor = tintColor
    }
    
    func embed(_ child: UIViewController) {
        addChild(child)
        child.view.loadInto(containerView: view)
        child.didMove(toParent: self)
    }
    
    func removeFromParentController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
