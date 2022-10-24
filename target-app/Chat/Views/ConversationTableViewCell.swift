//
//  ConversationTableViewCell.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 21/10/2022.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
    private let avatarImageSpacing: CGFloat = 20
    private let topicIconSpacing: CGFloat = 20
    private let stackViewSpacing: CGFloat = 20
    private let unreadMessagesSpacing: CGFloat = 7
    private let avatarImageSize: CGFloat = 50
    private let unreadMessagesLabelSize: CGFloat = 20
    private let topicIconSize: CGFloat = 25

    private lazy var avatarImage: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = avatarImageSize / 2
        imgView.backgroundColor = .systemYellow
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private var topicIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private var fullNameLabel = UILabel(style: .secondary())
    private var lastMessageLabel = UILabel(style: .secondary(isBold: false))
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var unreadMessagesLabel: UILabel = {
        let label = UILabel(style: .secondary(textColor: .white))
        label.layer.cornerRadius = unreadMessagesLabelSize / 2
        label.layer.masksToBounds = true
        label.backgroundColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews(subviews: [
            avatarImage,
            stackView,
            topicIcon,
            unreadMessagesLabel
        ])
        
        stackView.addArrangedSubview(subviews: [
            fullNameLabel,
            lastMessageLabel,
        ])
        
        avatarImage.centerVertically(with: contentView)
        topicIcon.centerVertically(with: contentView)
        stackView.centerVertically(with: contentView)
        
        NSLayoutConstraint.activate([
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: avatarImageSpacing),
            stackView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: stackViewSpacing),
            stackView.trailingAnchor.constraint(equalTo: topicIcon.leadingAnchor, constant: stackViewSpacing),
            topicIcon.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: topicIconSpacing),
            topicIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -topicIconSpacing),
            unreadMessagesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -unreadMessagesSpacing)
        ])

        NSLayoutConstraint.activate([
            avatarImage.heightAnchor.constraint(equalToConstant: avatarImageSize),
            avatarImage.widthAnchor.constraint(equalToConstant: avatarImageSize),
            topicIcon.topAnchor.constraint(equalTo: topAnchor),
            topicIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            topicIcon.heightAnchor.constraint(equalToConstant: topicIconSize),
            topicIcon.widthAnchor.constraint(equalToConstant: topicIconSize),
            unreadMessagesLabel.heightAnchor.constraint(equalToConstant: unreadMessagesLabelSize),
            unreadMessagesLabel.widthAnchor.constraint(equalToConstant: unreadMessagesLabelSize),
            unreadMessagesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: unreadMessagesSpacing)
        ])
    }
    
    func updateData(match: Match) {
        avatarImage.image = UIImage(named: match.user.avatar.smallThumbUrl!)
        topicIcon.image = UIImage(named: match.topicIcon)
        fullNameLabel.text = match.user.fullName
        lastMessageLabel.text = match.lastMessage
        unreadMessagesLabel.text = String(match.unreadMessages)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
