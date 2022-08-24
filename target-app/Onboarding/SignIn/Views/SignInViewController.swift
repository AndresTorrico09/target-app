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
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var contentView: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
    
    //EMPTY VIEWS
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
        
        setupViews()
        setupLayout()
        
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

        activateConstraints()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setupLayout() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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
