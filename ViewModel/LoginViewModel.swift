//
//  LoginViewModel.swift
//  CrptoWllet
//
//  Created by V K on 18.05.2023.
//

import UIKit

protocol LoginViewModelProtocol {
    func validateLogin(login: String, password: String) -> CredentialsStatus
    func performLoggingIn()
}


enum CredentialsStatus: String {
    case valid
    case invalid
    case noData
    
    func validate(status: CredentialsStatus) -> String {
        switch status {
        case .valid:
            return ""
        case .invalid:
            return "Invalid Info"
        case .noData:
            return "Please fill all the fields"
        }
    }
    
}

final class LoginViewModel: LoginViewModelProtocol {
    
    func validateLogin(login: String, password: String) -> CredentialsStatus {
        guard !login.isEmpty, !password.isEmpty else { return .noData }
        
        let hardcodedLogin: String = "1234"
        let hardcodedPassword: String = "1234"
        
        if login == hardcodedLogin && password == hardcodedPassword {
            return .valid
        } else {
            return .invalid
        }
    }
    
    func performLoggingIn() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootViewController(to: .loggedIn)
        }
    }
    
}

