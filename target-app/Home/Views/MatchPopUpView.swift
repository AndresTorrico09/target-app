//
//  MatchPopUp.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 07/11/2022.
//

import UIKit

final class MatchPopUpView: UIView {
    
    private let avatarImageSize: CGFloat = 40
    
    private var targetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_new_match")
        return imageView
    }()
    
    private lazy var titleLabel = UILabel(style: .primary(text: "home_new_match_label_1".localized))

    private lazy var subtitleLabel = UILabel(style: .primary(text: "home_new_match_label_2".localized))
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = avatarImageSize / 2
        imageView.backgroundColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avatar_mock_1")
        return imageView
    }()
    
    private lazy var userNameLabel = UILabel(style: .secondary(text: "Belu Iglesias"))
    
    private lazy var startChattingButton = UIButton(
        style: .secondary(color: .orange, title: "home_new_match_chat_button".localized, titleColor: .white),
        tapHandler: (target: self, action: #selector(tapOnStartChatting))
    )
    
    private lazy var skipButton = UIButton(
        style: .secondary(title: "home_new_match_skip_button".localized),
        tapHandler: (target: self, action: #selector(tapOnSkip))
    )
    
    weak var delegate: MatchPopUpPresenter?
    
    init() {
        super.init(frame: .zero)

        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowRadius = 20

        addSubviews(subviews: [
            titleLabel,
            subtitleLabel,
            targetImage,
            avatarImage,
            userNameLabel,
            startChattingButton,
            skipButton
        ])
        
        targetImage.centerHorizontally(with: self)
        
        [titleLabel,
         subtitleLabel,
         startChattingButton,
         skipButton,
        ].forEach {
            $0.attachHorizontally(
                to: self,
                leadingMargin: UI.Defaults.margin,
                trailingMargin: UI.Defaults.margin
            )
        }
        
        NSLayoutConstraint.activate([
            targetImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 22),
            titleLabel.topAnchor.constraint(equalTo: targetImage.bottomAnchor, constant: 22),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22),
            
            avatarImage.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 22),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 44),
            avatarImage.heightAnchor.constraint(equalToConstant: avatarImageSize),
            avatarImage.widthAnchor.constraint(equalToConstant: avatarImageSize),
            
            userNameLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 12),

            startChattingButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor),
            skipButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    
    @objc func tapOnStartChatting(_ sender: Any) {
        delegate?.startChattingButtonTapped()
    }
    
    @objc func tapOnSkip(_ sender: Any) {
        delegate?.skipButtonTapped()
    }
    
}
