//
//  SaveTargetBottomSheetViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 14/09/2022.
//

import UIKit

class SaveTargetBottomSheetViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var areaLabel = UILabel(style: .secondary(text: "home_area_label".localized))
    private lazy var areaField = UITextField(
        target: self,
        placeholder: "home_area_field_placeholder".localized
    )
    
    private lazy var titleLabel = UILabel(style: .secondary(text: "home_title_label".localized))
    private lazy var titleField = UITextField(
        target: self,
        placeholder: "home_title_field_placeholder".localized
    )
    
    private lazy var topicLabel = UILabel(style: .secondary(text: "home_topic_label".localized))
    private lazy var topicField = UITextField(
        target: self,
        placeholder: "home_topic_field_placeholder".localized
    )
    
    private lazy var saveButton = UIButton(
        style: .primary(title: "home_save_button".localized)
    )
    
    // MARK: - Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyBottomSheetUIConfigs()
        configureViews()
    }
}

private extension SaveTargetBottomSheetViewController {
    func configureViews() {
        view.addSubviews(subviews: [
            areaLabel,
            areaField,
            titleLabel,
            titleField,
            topicLabel,
            topicField,
            saveButton
        ])
        
        [areaLabel,
         areaField,
         titleLabel,
         titleField,
         topicLabel,
         topicField
        ].forEach {
            $0.attachHorizontally(
                to: view,
                leadingMargin: UI.Defaults.margin,
                trailingMargin: UI.Defaults.margin
            )
        }
        
        saveButton.attachHorizontally(
            to: view,
            leadingMargin: UI.Button.width,
            trailingMargin: UI.Button.width
        )
        
        NSLayoutConstraint.activate([
            areaLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            areaField.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: UI.TextField.spacing),
            titleLabel.topAnchor.constraint(equalTo: areaField.bottomAnchor, constant: UI.Label.spacing),
            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UI.TextField.spacing),
            topicLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: UI.Label.spacing),
            topicField.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: UI.TextField.spacing),
            saveButton.topAnchor.constraint(equalTo: topicField.bottomAnchor, constant: UI.Defaults.margin),
        ])
    }
}
