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
    case signUp
    
    var screen: UIViewController {
        switch self {
        case .signIn:
            return buildSignInViewController()
        case .signUp:
            return buildSignUpViewController()
        }
    }
    
    private func buildSignInViewController() -> UIViewController {
        let signIn = ChatsViewController()
        return signIn
    }
    
    private func buildSignUpViewController() -> UIViewController {
        let signUp = SignUpViewController(viewModel: SignUpViewModel())
        return signUp
    }
}
