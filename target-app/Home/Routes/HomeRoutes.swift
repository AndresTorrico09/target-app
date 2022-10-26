//
//  HomeRoutes.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 02/09/2022.
//

import Foundation
import UIKit

enum HomeRoutes: Route {
    case home
    case chats
    
    var screen: UIViewController {
        switch self {
        case .home:
            let home = HomeViewController(
                locationManager: LocationManager.shared,
                viewModel: HomeViewModel(targetServices: TargetServices())
            )
            return home
        case .chats:
            return ChatsViewController(viewModel: ChatsViewModel(conversationsServices: ConversationsServices()))
        }
    }
}
