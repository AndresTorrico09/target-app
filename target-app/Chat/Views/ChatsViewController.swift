//
//  ChatsViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 19/10/2022.
//

import UIKit

class ChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDefaultUIConfigs()
        setupNavigationBar()

    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.titleView = UILabel(style: .secondary(text: "Chat"))
        
        let barLeftButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_home_profile"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.leftBarButtonItem = barLeftButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let barRightButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_chat_map"),
            style: .plain,
            target: self,
            action: #selector(tapOnMapBarButton)
        )
        navigationItem.rightBarButtonItem = barRightButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    // MARK: - Actions

    @objc
    func tapOnMapBarButton(_ sender: Any) {
        AppNavigator.shared.navigate(to: HomeRoutes.home, with: .changeRoot)
    }

}
