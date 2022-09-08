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
    
    // MARK: - Observed Properties
    @Published private var state: AuthViewModelState = .network(state: .idle)

    // MARK: - Publishers
    var statePublisher: Published<AuthViewModelState>.Publisher { $state }
    
    private var email: String = ""
    private var password: String = ""
    
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
    
    func setEmailValue(email: String) {
        self.email = email
    }
    
    func setPasswordValue(password: String) {
        self.password = password
    }
}
