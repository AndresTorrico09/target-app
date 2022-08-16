//
//  OnboardingRoutes.swift
//  ios-base
//
//  Created by Mauricio Cousillas on 6/13/19.
//  Copyright © 2019 Rootstrap Inc. All rights reserved.
//

import Foundation
import UIKit

enum OnboardingRoutes: Route {
    case signIn
    
    var screen: UIViewController {
        switch self {
        case .signIn:
            return buildSignInViewController()
        }
    }
    
    private func buildSignInViewController() -> UIViewController {
        let signIn = SignInViewController()
        return signIn
    }
}
