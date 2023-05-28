//
//  UserDefaults+Extension.swift
//  CrptoWllet
//
//  Created by V K on 21.05.2023.
//

import Foundation.NSUserDefaults

extension UserDefaults {
    
    enum Login: String {
        case state
    }
    
    static let loginState: String = UserDefaults.Login.state.rawValue
    
}

enum UserLoginState: String {
    case loggedIn
    case loggedOut
}
