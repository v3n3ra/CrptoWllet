//
//  SceneDelegate.swift
//  CrptoWllet
//
//  Created by V K on 15.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var navigationController: UINavigationController?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootViewController: UIViewController
        
        let loginVM = LoginViewModel()
        let mainVM = MainViewModel()
        
        if let userLoginState = UserDefaults.standard.string(forKey: UserDefaults.loginState),
           let loginState = UserLoginState(rawValue: userLoginState) {
            switch loginState {
            case .loggedIn:
                rootViewController = CoinsViewController(vm: mainVM)
            case .loggedOut:
                rootViewController = LoginViewController(vm: loginVM)
            }
        } else {
            rootViewController = LoginViewController(vm: loginVM)
        }
        
        navigationController = UINavigationController(rootViewController: rootViewController)
        
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func changeRootViewController(to state: UserLoginState) {
        switch state {
        case .loggedIn:
            UserDefaults.standard.set(UserLoginState.loggedIn.rawValue,
                                      forKey: UserDefaults.loginState)
            let mainVM = MainViewModel()
            navigationController?.setViewControllers([CoinsViewController(vm: mainVM)], animated: true)
        case .loggedOut:
            UserDefaults.standard.set(UserLoginState.loggedOut.rawValue,
                                      forKey: UserDefaults.loginState)
            let loginVM = LoginViewModel()
            navigationController?.setViewControllers([LoginViewController(vm: loginVM)], animated: true)
        }
    }
    
}

