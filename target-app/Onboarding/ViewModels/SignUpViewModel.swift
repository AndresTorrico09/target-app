//
//  SignUpViewModel.swift
//  target-app
//
//  Created by Andres Leonel Torrico Cossio on 29/08/2022.
//

import Foundation

protocol SignUpViewModelDelegate: AuthViewModelStateDelegate {
    func formDidChange()
}

enum AuthViewModelState {
    case loggedIn
    case network(state: NetworkState)
}

class SignUpViewModel {
    
    weak var delegate: SignUpViewModelDelegate?
    
    private var state: AuthViewModelState = .network(state: .idle) {
        didSet {
            delegate?.didUpdateState(to: state)
        }
    }
    
    var name = "" {
        didSet {
            delegate?.formDidChange()
        }
    }
    
    var email = "" {
        didSet {
            delegate?.formDidChange()
        }
    }
    
    var password = "" {
        didSet {
            delegate?.formDidChange()
        }
    }
    
    var passwordConfirmation = "" {
        didSet {
            delegate?.formDidChange()
        }
    }
    
    var gender = "" {
        didSet {
            gender = gender.lowercased()
            delegate?.formDidChange()
        }
    }
    
    func signUp() {
        state = .network(state: .loading)
        AuthenticationServices.signUp(
            name: name,
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation,
            gender: gender
        ) {
            [weak self] result in
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
