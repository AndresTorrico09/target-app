//
//  TargetBottomSheetViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 12/09/2022.
//

import UIKit

class TargetBottomSheetViewController: UIViewController {
    
    private var targetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named:"ic_create_target")
        return imageView
    }()
    
    private lazy var createButton = UIButton(
        style: .secondary(title: "home_create_target_label".localized),
        tapHandler: (target: self, action: #selector(tapOnCreateNewTarget))
    )
    
    // MARK: - Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyBottomSheetUIConfigs()
        
        view.addSubviews(subviews: [
            targetImage,
            createButton
        ])
        
        targetImage.centerHorizontally(with: view)

        createButton.attachHorizontally(
            to: view,
            leadingMargin: UI.Defaults.margin,
            trailingMargin: UI.Defaults.margin
        )
        
        NSLayoutConstraint.activate([
            targetImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            createButton.topAnchor.constraint(
                equalTo: targetImage.bottomAnchor
            )
        ])
    }
    
    // MARK: - Actions
    
    @objc func tapOnCreateNewTarget(_ sender: Any) {
        let saveTargetBottomSheetViewController = SaveTargetBottomSheetViewController()
        let nav = UINavigationController(rootViewController: saveTargetBottomSheetViewController)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(nav, animated: true, completion: nil)
    }
    
}
