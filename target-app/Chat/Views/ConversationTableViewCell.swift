//
//  ConversationTableViewCell.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 21/10/2022.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
    private let topicIconSpacing: CGFloat = 20
    private let stackViewSpacing: CGFloat = 10
    private let avatarImageSize: CGFloat = 10

    private var avatarImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .center
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = imgView.bounds.width / 2
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
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews(subviews: [
            avatarImage,
            stackView,
            topicIcon
        ])
        
        stackView.addArrangedSubview(subviews: [
            fullNameLabel,
            lastMessageLabel,
        ])
        
        avatarImage.centerVertically(with: contentView)
        topicIcon.centerVertically(with: contentView)
        stackView.centerVertically(with: contentView)
        
        NSLayoutConstraint.activate([
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 350),
            avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -350),
            stackView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: stackViewSpacing),
            stackView.trailingAnchor.constraint(equalTo: topicIcon.leadingAnchor, constant: stackViewSpacing),
            topicIcon.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: topicIconSpacing),
            topicIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -topicIconSpacing)
        ])

        NSLayoutConstraint.activate([
            topicIcon.topAnchor.constraint(equalTo: topAnchor),
            topicIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            topicIcon.heightAnchor.constraint(equalToConstant: 25),
            topicIcon.widthAnchor.constraint(equalToConstant: 25),
            avatarImage.topAnchor.constraint(equalTo: topAnchor),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatarImage.leftAnchor.constraint(equalTo: leftAnchor),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor)
        ])
    }
    
    func updateData(match: Match) {
        avatarImage.image = UIImage(named: match.user.avatar.smallThumbUrl!)
        topicIcon.image = UIImage(named: match.topicIcon)
        fullNameLabel.text = match.user.fullName
        lastMessageLabel.text = match.lastMessage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
