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
    
    private var titleLabel = UILabel(style: .secondary(text: "create_target_label".localized))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyBottomSheetUIConfigs()
        
        view.addSubviews(subviews: [
            targetImage,
            titleLabel
        ])
        
        targetImage.centerHorizontally(with: view)

        titleLabel.attachHorizontally(
            to: view,
            leadingMargin: UI.Defaults.margin,
            trailingMargin: UI.Defaults.margin
        )
        
        NSLayoutConstraint.activate([
            targetImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            titleLabel.topAnchor.constraint(
                equalTo: targetImage.bottomAnchor,
                constant: 20
            )
        ])

    }
    
}
