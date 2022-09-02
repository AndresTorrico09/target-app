//
//  SignUpViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 26/08/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - ViewModels
    
    private let viewModel: SignUpViewModel
    
    // MARK: - Outlets

    private lazy var overlayImageView = UIImageView()
    
    private lazy var titleLabel = UILabel(style: .primary(text: "signin_title".localized))
    
    private lazy var nameLabel = UILabel(style: .secondary(text: "signup_name_label".localized))
    private lazy var nameField = UITextField(
        target: self,
        selector: #selector(formEditingChange)
    )
    private lazy var nameErrorLabel = UILabel(style: .error(text: "signup_name_label_error".localized))

    private lazy var emailLabel = UILabel(style: .secondary(text: "signin_email_label".localized))
    private lazy var emailField = UITextField(
        target: self,
        selector: #selector(formEditingChange)
    )
    private lazy var emailErrorLabel = UILabel(style: .error(text: "signup_email_label_error".localized))
    
    private lazy var passwordLabel = UILabel(style: .secondary(text: "signin_password_label".localized))
    private lazy var passwordField = UITextField(
        target: self,
        selector: #selector(formEditingChange),
        placeholder: "signup_password_placeholder".localized,
        isPassword: true
    )
    private lazy var passwordErrorLabel = UILabel(style: .error(text: "signup_email_password_error".localized))

    private lazy var confirmPasswordLabel = UILabel(style: .secondary(text: "signup_confirm_password_label".localized))
    private lazy var passwordConfirmationField = UITextField(
        target: self,
        selector: #selector(formEditingChange),
        isPassword: true
    )
    
    lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    private lazy var genderLabel = UILabel(style: .secondary(text: "signup_gender_label".localized))
    private lazy var genderField = UITextField(
        target: self,
        selector: #selector(formEditingChange),
        placeholder: "signup_gender_placeholder".localized,
        pickerView: picker
    )
    
    private lazy var signInButton = UIButton(
        style: .secondary(title: "signin_button_text".localized)
    )

    private lazy var lineView = UIView()
    
    private lazy var signUpButton = UIButton(
        style: .primary(title: "signup_button_text".localized),
        tapHandler: (target: self, action: #selector(tapOnSignUpButton))
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
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var genders: [String] = {
      let genders = ["Male", "Female"]
        return genders
    }()
    
    init(viewModel: SignUpViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.dataSource = self
        self.picker.delegate = self
        
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
      }
    
    // MARK: - Actions

    @objc
    func tapOnSignUpButton(_ sender: Any) {
        if checkAndDisplayError() {
            viewModel.signUp()
        }
    }
    
    @objc
    func formEditingChange(_ sender: UITextField) {
        let newValue = sender.text ?? ""
        switch sender {
        case nameField:
            viewModel.name = newValue
        case emailField:
            viewModel.email = newValue
        case passwordField:
            viewModel.password = newValue
        case passwordConfirmationField:
            viewModel.passwordConfirmation = newValue
        case genderField:
            viewModel.gender = newValue
        default: break
        }
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
            nameErrorLabel,
            emailLabel,
            emailField,
            emailErrorLabel,
            passwordLabel,
            passwordField,
            passwordErrorLabel,
            confirmPasswordLabel,
            passwordConfirmationField,
            genderLabel,
            genderField,
            signUpButton,
            lineView,
            signInButton
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
         passwordConfirmationField,
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
    
    func checkAndDisplayError() -> Bool {
        var valid = true
        
        if nameField.text!.isEmpty {
            nameErrorLabel.isHidden = false
            valid = false
        } else {
            nameErrorLabel.isHidden = true
        }
        
        if emailField.text!.isEmpty || !emailField.text!.isEmailFormatted() {
            emailErrorLabel.isHidden = false
            valid = false
        } else {
            emailErrorLabel.isHidden = true
        }
        
        if passwordField.text!.count < 6  {
            passwordErrorLabel.isHidden = false
            valid = false
        } else {
            passwordErrorLabel.isHidden = true
        }
        
        return valid
    }

}
