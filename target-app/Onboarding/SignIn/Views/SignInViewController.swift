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
            overlayImageView,
            titleLabel,
            emailLabel,
            emailField,
            passwordLabel,
            passwordField,
            signInButton,
            forgotPasswordButton,
            connectFacebookButton,
            lineView,
            signUpButton
        ])
        
        activateConstraints()
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
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 100
            ),
            emailLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 100
            ),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            emailField.topAnchor.constraint(
                equalTo: emailLabel.bottomAnchor,
                constant: 20
            ),
            passwordLabel.topAnchor.constraint(
                equalTo: emailField.bottomAnchor,
                constant: 20
            ),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.topAnchor.constraint(
                equalTo: passwordLabel.bottomAnchor,
                constant: 20
            ),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.topAnchor.constraint(
                equalTo: passwordField.bottomAnchor,
                constant: 40
            ),
            forgotPasswordButton.topAnchor.constraint(
                equalTo: signInButton.bottomAnchor,
                constant: 15
            ),
            connectFacebookButton.topAnchor.constraint(
                equalTo: forgotPasswordButton.bottomAnchor,
                constant: 35
            ),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -120
            ),
            signUpButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -60
            )
        ])
    }
}
