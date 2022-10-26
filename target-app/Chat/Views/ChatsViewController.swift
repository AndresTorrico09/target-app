//
//  ChatsViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 19/10/2022.
//

import UIKit
import Combine

final class ChatsViewController: UIViewController {
    
    // MARK: - ViewModels
    
    private let viewModel: ChatsViewModel
    //TODO: remove mock
    var data: [Match] = [
        Match(matchID: 0, topicIcon: "ic_topic_travel", lastMessage: "¡Hola! A dónde querés viajar?", unreadMessages: 0, user: User(id: 0 ,firstName: "name", lastName: "last", fullName: "José Gazzano", name: "name", username: "user", email: "email", gender: "gender", password: nil, passwordConfirmation: nil, avatar: User.Avatar(smallThumbUrl: "avatar_mock_1"))),
        Match(matchID: 1, topicIcon: "ic_topic_movie", lastMessage: "¿Alguna película para recomendar?", unreadMessages: 1, user: User(id: 1 ,firstName: "name1", lastName: "last1", fullName: "Karen Bauer", name: "name 1", username: "user 1", email: "email1", gender: "gender1", password: nil, passwordConfirmation: nil, avatar: User.Avatar(smallThumbUrl: "avatar_mock_2")))
    ]
    enum ViewControllerSection: Hashable {
        case main
    }
    
    private lazy var tableViewDataSource: UITableViewDiffableDataSource<ViewControllerSection, Match> = {
        let dataSource = UITableViewDiffableDataSource<ViewControllerSection, Match>(tableView: tableView) {
            tableView, _, model in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.reuseIdentifier)
            if let cell = cell as? ConversationTableViewCell {
                cell.updateData(match: model)
            }
            return cell
        }
        
        return dataSource
    }()
    
    // MARK: - Outlets
    
    private let tableViewRowHeight: CGFloat = 80
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: ConversationTableViewCell.reuseIdentifier)
        tableView.rowHeight = tableViewRowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDefaultUIConfigs()
        configureViews()
        
        //        setupBinders()
        //        viewModel.getMatchConversations()
    }
    
    init(viewModel: ChatsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    func tapOnMapBarButton(_ sender: Any) {
        AppNavigator.shared.navigate(to: HomeRoutes.home, with: .changeRoot)
    }
    
    // MARK: - BINDERS
    private var cancellables = Set<AnyCancellable>()
    private var matches: [Match] = []
    
    func setupBinders() {
        viewModel.$matches
            .sink{ [weak self] matches in
                self?.matches = matches
            }.store(in: &cancellables)
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
    
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        configureSnapshot()
    }
    
    func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewControllerSection, Match>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
    }
}
