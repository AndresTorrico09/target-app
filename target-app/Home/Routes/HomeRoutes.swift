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
    case bottomSheetSaveTarget(viewModel: SaveTargetViewModel, presentedViewController: UIViewController)
    
    var screen: UIViewController {
        switch self {
        case .home:
            let home = HomeViewController(
                viewModel: HomeViewModel(
                    locationManager: LocationManager.shared,
                    targetServices: TargetServices()
                )
            )
            return home
        case .chats:
            return ChatsViewController(
                viewModel: ChatsViewModel(conversationsServices: ConversationsServices())
            )
        case .bottomSheetSaveTarget(let viewModel, let presentedViewController):
            return buildSaveTargetViewController(
                viewModel: viewModel,
                presentedViewController: presentedViewController
            )
        }
    }
    
    private func buildSaveTargetViewController(
        viewModel: SaveTargetViewModel,
        presentedViewController: UIViewController
    ) -> UIViewController {
        
        let saveTargetViewController = SaveTargetViewController(viewModel: viewModel)
        
        let viewController = UISheetPresentationController(
            presentedViewController: presentedViewController,
            presenting: saveTargetViewController
        )

        if let sheet = viewController.presentingViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        return viewController.presentingViewController
    }
}
