//
//  HomeViewController.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 02/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDefaultUIConfigs()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.title = "home_title".localized
        
        let barLeftButtonItem = UIBarButtonItem(image: UIImage(named: "ic_home_profile"),
                                            style: .plain,
                                            target: self,
                                            action: nil)
        navigationItem.leftBarButtonItem = barLeftButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let barRightButtonItem = UIBarButtonItem(image: UIImage(named: "ic_home_chat"),
                                            style: .plain,
                                            target: self,
                                            action: nil)
        navigationItem.rightBarButtonItem = barRightButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
}
