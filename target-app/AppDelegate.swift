//
//  AppDelegate.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 10/08/2022.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let shared: AppDelegate = {
        guard let appD = UIApplication.shared.delegate as? AppDelegate else {
            return AppDelegate()
        }
        return appD
    }()
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let rootVC = AppNavigator.shared.rootViewController
        window?.rootViewController = rootVC
        
        return true
    }

    func unexpectedLogout() {
        //TODO: add action
    }
}
