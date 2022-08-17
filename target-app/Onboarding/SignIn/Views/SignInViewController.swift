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
    private lazy var emailField = UITextField()
    private lazy var passwordLabel = UILabel()
    private lazy var passwordField = UITextField()
    private lazy var signInButton = UIButton()
    private lazy var forgotPasswordButton = UIButton()
    private lazy var connectFacebookButton = UIButton()
    private lazy var lineView = UIView()
    private lazy var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 100
            ),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 100
            ),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            emailField.topAnchor.constraint(
                equalTo: emailLabel.bottomAnchor,
                constant: 20
            ),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordLabel.topAnchor.constraint(
                equalTo: emailField.bottomAnchor,
                constant: 20
            ),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
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
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            forgotPasswordButton.topAnchor.constraint(
                equalTo: signInButton.bottomAnchor,
                constant: 15
            ),
            connectFacebookButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            connectFacebookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            connectFacebookButton.topAnchor.constraint(
                equalTo: forgotPasswordButton.bottomAnchor,
                constant: 35
            ),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 128),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -128),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -110
            ),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            signUpButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -60
            )
        ])
        
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
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.borderStyle = .line
        let emailFieldParagraphStyle = NSMutableParagraphStyle()
        emailFieldParagraphStyle.alignment = .center
        let emailFieldPlaceholder = NSAttributedString(
            string: "target@mvd.com",
            attributes: [NSAttributedString.Key.paragraphStyle: emailFieldParagraphStyle]
        )
        emailField.attributedPlaceholder = emailFieldPlaceholder
        
        passwordLabel.textColor = UIColor.black
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.textAlignment = .center
        passwordLabel.text = "PASSWORD"
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.borderStyle = .line
        let passwordFieldParagraphStyle = NSMutableParagraphStyle()
        passwordFieldParagraphStyle.alignment = .center
        let passwordFieldPlaceholder = NSAttributedString(
            string: "**********",
            attributes: [NSAttributedString.Key.paragraphStyle: passwordFieldParagraphStyle]
        )
        passwordField.attributedPlaceholder = passwordFieldPlaceholder
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.backgroundColor = UIColor.black
        signInButton.setTitle("SIGN IN", for: .normal)
        
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.setTitleColor(UIColor.black, for: .normal)
        forgotPasswordButton.setTitle("Forgot your password?", for: .normal)
        
        connectFacebookButton.translatesAutoresizingMaskIntoConstraints = false
        connectFacebookButton.setTitleColor(UIColor.black, for: .normal)
        connectFacebookButton.setTitle("CONNECT WITH FACEBOOK", for: .normal)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.black.cgColor
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitleColor(UIColor.black, for: .normal)
        signUpButton.setTitle("SIGN UP", for: .normal)
        
        
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
    }
}
