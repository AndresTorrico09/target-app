//
//  SignUpViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 26/08/2022.
//

import UIKit

class SignUpViewController: UIViewController {

    private lazy var overlayImageView = UIImageView()
    
    private lazy var titleLabel = UILabel(style: .primary(text: "signin_title".localized))
    
    private lazy var nameLabel = UILabel(style: .secondary(text: "NAME"))
    
    private lazy var nameField = UITextField(
        target: self
    )

    private lazy var emailLabel = UILabel(style: .secondary(text: "signin_email_label".localized))
    
    private lazy var emailField = UITextField(
        target: self
    )
    
    private lazy var passwordLabel = UILabel(style: .secondary(text: "signin_password_label".localized))
    
    private lazy var passwordField = UITextField(
        target: self,
        placeholder: "MIN. 6 CHARACTERS LONG"
    )
    
    private lazy var confirmPasswordLabel = UILabel(style: .secondary(text: "CONFIRM PASSWORD"))
    
    private lazy var confirmPasswordField = UITextField(
        target: self
    )
    
    private lazy var genderLabel = UILabel(style: .secondary(text: "GENDER"))
    
    private lazy var genderField = UITextField(
        target: self,
        placeholder: "SELECT YOUR GENDER"
    )
    
    private lazy var signInButton = UIButton(
        style: .primary(title: "signin_button_text".localized)
    )

    private lazy var lineView = UIView()
    
    private lazy var signUpButton = UIButton(
        style: .secondary(title: "signup_button_text".localized)
    )
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var genders: [String] = {
      let genders = ["Male", "Female"]
        return genders
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.dataSource = self
        self.picker.delegate = self
        self.genderField.inputView = picker
        
        configureViews()
    }
}

extension SignUpViewController:  UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genders[row]
        genderField.resignFirstResponder()
    }
    
    func configureViews() {
        applyDefaultUIConfigs()
        
        let overlayImage = UIImage(named: "sign-in-overlay")
        overlayImageView.contentMode = UIView.ContentMode.scaleAspectFill
        overlayImageView.frame.size.width = view.bounds.width
        overlayImageView.frame.size.height = 190
        overlayImageView.image = overlayImage
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.black.cgColor
        
        view.addSubviews(subviews: [
            overlayImageView
        ])
        
        setupViews()
        setupLayout()
        
        stackView.addArrangedSubview(subviews: [
            titleLabel,
            nameLabel,
            nameField,
            emailLabel,
            emailField,
            passwordLabel,
            passwordField,
            confirmPasswordLabel,
            confirmPasswordField,
            genderLabel,
            genderField,
            signInButton,
            lineView,
            signUpButton
        ])
        
        activateConstraints()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func activateConstraints() {
        [titleLabel,
         nameLabel,
         nameField,
         emailLabel,
         emailField,
         passwordLabel,
         passwordField,
         confirmPasswordLabel,
         confirmPasswordField,
         genderLabel,
         genderField
        ].forEach {
            $0.attachHorizontally(
                to: view,
                leadingMargin: UI.TextField.width,
                trailingMargin: UI.TextField.width
            )
        }
        
        [signInButton,
         lineView,
         signUpButton,
        ].forEach {
            $0.attachHorizontally(
                to: view,
                leadingMargin: UI.Button.width,
                trailingMargin: UI.Button.width
            )
        }
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.1
            ),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

}
