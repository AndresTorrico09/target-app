//
//  SaveTargetBottomSheetViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 14/09/2022.
//

import UIKit

class SaveTargetViewController: UIViewController {
    
    // MARK: - ViewModels
    
    private let viewModel: SaveTargetViewModel
    
    // MARK: - Outlets
    
    private lazy var areaLabel = UILabel(style: .secondary(text: "home_area_label".localized))
    private lazy var areaField = UITextField(
        target: self,
        selector: #selector(formEditingChange),
        placeholder: "home_area_field_placeholder".localized
    )
    
    private lazy var titleLabel = UILabel(style: .secondary(text: "home_title_label".localized))
    private lazy var titleField = UITextField(
        target: self,
        selector: #selector(formEditingChange),
        placeholder: "home_title_field_placeholder".localized
    )
    
    private lazy var topicLabel = UILabel(style: .secondary(text: "home_topic_label".localized))
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    private lazy var topicsField = UITextField(
        target: self,
        selector: #selector(formEditingChange),
        placeholder: "home_topic_field_placeholder".localized,
        pickerView: picker
    )
    //TODO: get topic values from API
    private lazy var topics: [String] = {
      let topics = ["Football", "Pizza", "Dogs"]
        return topics
    }()
    
    private lazy var saveButton = UIButton(
        style: .primary(title: "home_save_button".localized),
        tapHandler: (target: self, action: #selector(saveTargetTapped))
    )
    
    // MARK: - Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.dataSource = self
        self.picker.delegate = self
        
        viewModel.setLocationSelected()
        applyBottomSheetUIConfigs()
        configureViews()
    }
    
    init(viewModel: SaveTargetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    func saveTargetTapped() {
        viewModel.saveTarget()
    }
    
    @objc
    func formEditingChange(_ sender: UITextField) {
        let newValue = sender.text ?? ""
        
        switch sender {
        case areaField:
            viewModel.setArea(radius: newValue)
        case titleField:
            viewModel.setTitle(title: newValue)
        case topicsField:
            viewModel.setTopicId(topicId: newValue)
        default: break
        }
    }
}

extension SaveTargetViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        topics[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        topicsField.text = topics[row]
        topicsField.resignFirstResponder()
    }
    
    func configureViews() {
        view.addSubviews(subviews: [
            areaLabel,
            areaField,
            titleLabel,
            titleField,
            topicLabel,
            topicsField,
            saveButton
        ])
        
        [areaLabel,
         areaField,
         titleLabel,
         titleField,
         topicLabel,
         topicsField
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
            topicsField.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: UI.TextField.spacing),
            saveButton.topAnchor.constraint(equalTo: topicsField.bottomAnchor, constant: UI.Defaults.margin),
        ])
    }
}
