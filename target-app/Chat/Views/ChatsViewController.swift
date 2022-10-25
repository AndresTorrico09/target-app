//
//  ChatsViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 19/10/2022.
//

import UIKit

class ChatsViewController: UIViewController {

    private let tableViewRowHeight: CGFloat = 80

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: ConversationTableViewCell.reuseIdentifier)
        tableView.rowHeight = tableViewRowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //TODO: remove mock
    var data: [Match] = [
        Match(matchID: 0, topicIcon: "ic_topic_travel", lastMessage: "¡Hola! A dónde querés viajar?", unreadMessages: 0, user: User(id: 0 ,firstName: "name", lastName: "last", fullName: "José Gazzano", name: "name", username: "user", email: "email", gender: "gender", password: nil, passwordConfirmation: nil, avatar: User.Avatar(smallThumbUrl: "avatar_mock_1"))),
        Match(matchID: 1, topicIcon: "ic_topic_movie", lastMessage: "¿Alguna película para recomendar?", unreadMessages: 1, user: User(id: 1 ,firstName: "name1", lastName: "last1", fullName: "Karen Bauer", name: "name 1", username: "user 1", email: "email1", gender: "gender1", password: nil, passwordConfirmation: nil, avatar: User.Avatar(smallThumbUrl: "avatar_mock_2")))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDefaultUIConfigs()
        configureViews()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
                
        tableView.dataSource = self
    }
    
    // MARK: - Actions

    @objc
    func tapOnMapBarButton(_ sender: Any) {
        AppNavigator.shared.navigate(to: HomeRoutes.home, with: .changeRoot)
    }

}

extension ChatsViewController {
    func configureViews() {
        setupTableView()
        
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_home_profile"),
            style: .plain,
            target: self,
            action: nil
        )
        
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_chat_map"),
            style: .plain,
            target: self,
            action: #selector(tapOnMapBarButton)
        )
        
        setupNavigationBar(
            title: "chat_title".localized,
            leftButton: leftBarButtonItem,
            rightButton: rightBarButtonItem
        )
    }
}

extension ChatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? ConversationTableViewCell {
            cell.updateData(match: data[indexPath.row])
        }
        return cell
    }
}
