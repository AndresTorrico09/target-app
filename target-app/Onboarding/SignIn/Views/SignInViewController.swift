//
//  SignInViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 12/08/2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    private lazy var overlayImageView = UIImageView()
    
    private lazy var titleLabel = UILabel.titleLabel(text: "signin_title".localized)
    
    private lazy var emailLabel = UILabel.textFieldLabel(text: "signin_email_label".localized)
    
    private lazy var emailField = UITextField(
        target: self,
        placeholder: "signin_email_placeholder".localized
    )
    
    private lazy var passwordLabel = UILabel.textFieldLabel(text: "signin_password_label".localized)
    
    private lazy var passwordField = UITextField(
        target: self,
        placeholder: "signin_password_placeholder".localized
    )
    
    private lazy var signInButton = UIButton.primaryButton(
        title: "signin_button_text".localized
    )
    
    private lazy var forgotPasswordButton = UIButton.secondaryButton(
        title: "forgot_password_button_text".localized
    )
    
    private lazy var connectFacebookButton = UIButton.secondaryButton(
        title: "connect_facebook_button_text".localized
    )
    
    private lazy var lineView = UIView()

    private lazy var signUpButton = UIButton.secondaryButton(
        title: "signup_button_text".localized
    )
    
    private lazy var stackView = UIStackView()
    
    //EMPTYs VIEWS
    private lazy var topSpaceView = UIView()
    private lazy var bottomSpaceView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
}

private extension SignInViewController {
    func configureViews() {
        applyDefaultUIConfigs()
        
        let overlayImage = UIImage(named: "sign-in-overlay")
        overlayImageView.contentMode = UIView.ContentMode.scaleAspectFill
        overlayImageView.frame.size.width = view.bounds.width
        overlayImageView.frame.size.height = 290
        overlayImageView.image = overlayImage
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.black.cgColor
                
        view.addSubviews(subviews: [
            overlayImageView
        ])
        
        stackView.addArrangedSubview(subviews: [
            titleLabel,
            topSpaceView,
            emailLabel,
            emailField,
            passwordLabel,
            passwordField,
            signInButton,
            forgotPasswordButton,
            connectFacebookButton,
            bottomSpaceView,
            lineView,
            signUpButton
        ])
        
        view.addSubview(stackView)
        
        configureStackView()

        activateConstraints()
        
    }
    
    func configureStackView () {
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
//        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 20
//        stackView.backgroundColor = .systemYellow
        
        // Constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerVertically(with: view)
//        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -20).isActive = true
    }
    
    func activateConstraints() {
        [titleLabel,
         emailLabel,
         emailField,
         passwordLabel,
         passwordField,
         forgotPasswordButton,
         connectFacebookButton
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
            topSpaceView.heightAnchor.constraint(equalToConstant: 80),
            bottomSpaceView.heightAnchor.constraint(equalToConstant: 80),
//            titleLabel.topAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.topAnchor,
//                constant: 80
//            ),
            lineView.heightAnchor.constraint(equalToConstant: 1),
//            lineView.bottomAnchor.constraint(
//                equalTo: signUpButton.topAnchor,
//                constant: -10
//            ),
//            signUpButton.bottomAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
//                constant: -40
//            )
        ])
    }
}
