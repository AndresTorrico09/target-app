//
//  SignInViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 12/08/2022.
//

import UIKit

class SignInViewController: UIViewController {
    
    private lazy var overlayImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var emailLabel = UILabel()
    private lazy var emailField = UITextField(
        target: self,
        placeholder: "target@mvd.com"
    )
    
    private lazy var passwordLabel = UILabel()
    private lazy var passwordField = UITextField(
        target: self,
        placeholder: "**********"
    )
    
    private lazy var signInButton = UIButton.primaryButton(
        title: "SIGN IN"
    )
    
    private lazy var forgotPasswordButton = UIButton()
    private lazy var connectFacebookButton = UIButton.secondaryButton(
        title: "CONNECT WITH FACEBOOK"
    )
    
    private lazy var lineView = UIView()
    private lazy var signUpButton = UIButton.secondaryButton(
        title: "SIGN UP"
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
        
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "TARGET MVD"
        titleLabel.font = titleLabel.font.withSize(25)
        
        emailLabel.textColor = UIColor.black
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textAlignment = .center
        emailLabel.text = "EMAIL"
        
        passwordLabel.textColor = UIColor.black
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.textAlignment = .center
        passwordLabel.text = "PASSWORD"
        
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.setTitleColor(UIColor.black, for: .normal)
        forgotPasswordButton.setTitle("Forgot your password?", for: .normal)

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
        [
            titleLabel,
            emailLabel,
            emailField,
            passwordLabel,
            passwordField,
            forgotPasswordButton,
            connectFacebookButton
        ].forEach {
            $0.attachHorizontally(to: view)
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
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 128),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -128),
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
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 128),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -128),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -120
            ),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 128),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -128),
            signUpButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -60
            )
        ])
    }
}
