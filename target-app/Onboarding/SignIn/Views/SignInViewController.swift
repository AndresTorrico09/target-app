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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        
        setupViews()
        setupLayout()
        
        stackView.addArrangedSubview(subviews: [
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
         emailLabel,
//         emailField,
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
            titleLabel.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.2
            ),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
