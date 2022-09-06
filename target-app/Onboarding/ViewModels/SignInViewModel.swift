//
//  SignIn.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 06/09/2022.
//

import Foundation

protocol SignInViewModelDelegate: AuthViewModelStateDelegate {
    func didUpdateCredentials()
}

class SignInViewModel {
    
    private var state: AuthViewModelState = .network(state: .idle) {
        didSet {
            delegate?.didUpdateState(to: state)
        }
    }
    
    weak var delegate: SignInViewModelDelegate?
    
    var email = "" {
        didSet {
            delegate?.didUpdateCredentials()
        }
    }
    
    var password = "" {
        didSet {
            delegate?.didUpdateCredentials()
        }
    }
    
    var hasValidCredentials: Bool {
        email.isEmailFormatted() && !password.isEmpty
    }
    
    func signIn() {
        state = .network(state: .loading)
        AuthenticationServices.signIn(
            email: email,
            password: password
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.state = .loggedIn
                AppNavigator.shared.navigate(to: HomeRoutes.home, with: .changeRoot)
            case .failure(let error):
                self.state = .network(state: .error(error.localizedDescription))
            }
        }
    }
}
