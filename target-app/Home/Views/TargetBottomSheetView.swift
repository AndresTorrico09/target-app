//
//  TargetBottomSheetViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 12/09/2022.
//

import UIKit

final class TargetBottomSheetView: UIView {
    
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
    
    weak var delegate: BottomSheetPresenter?
    
    init () {
        super.init(frame: .zero)

        backgroundColor = .white
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowRadius = 20

        addSubviews(subviews: [
            targetImage,
            createButton
        ])
        
        targetImage.centerHorizontally(with: self)

        createButton.attachHorizontally(
            to: self,
            leadingMargin: UI.Defaults.margin,
            trailingMargin: UI.Defaults.margin
        )
        
        NSLayoutConstraint.activate([
            targetImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            createButton.topAnchor.constraint(
                equalTo: targetImage.bottomAnchor
            )
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func tapOnCreateNewTarget(_ sender: Any) {
        delegate?.createTargetButtonTapped()
    }
    
}
