//
//  LoginViewController.swift
//  CrptoWllet
//
//  Created by V K on 15.04.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let vm: LoginViewModelProtocol
    
    //MARK: - UI Elements
    
    private let loginField: UITextField = Reusable.textField(placeholder: "Login", isSecure: false)
    private let passwordField: UITextField  = Reusable.textField(placeholder: "Password", isSecure: true)
    private let loginButton: UIButton = UIButton()
    
    //MARK: - Init
    
    init(vm: LoginViewModelProtocol) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // gradient background layer
        let gradient = Gradient.makeLayer()
        view.layer.insertSublayer(gradient, at: .zero)

        
        configureLoginButton()
        layout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: - Extension with methods

private extension LoginViewController {
    
    func configureLoginButton() {
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(hex: "2d4a58")
        loginButton.layer.cornerRadius = UIConstants.cornerRad
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func layout() {
        [loginField, passwordField, loginButton].forEach { subview in
            view.addSubview(subview)
        }
        
        loginField.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.w/1.5)
            make.height.equalTo(UIConstants.h/20)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(UIConstants.h/4)
        }
        
        passwordField.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.w/1.5)
            make.height.equalTo(UIConstants.h/20)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(UIConstants.h/3)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.w/1.5)
            make.height.equalTo(UIConstants.h/15)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(UIConstants.h/2.2)
        }
    }
    
    //MARK: - @Obj-C
    
    @objc func loginButtonTapped() {
        guard let login = loginField.text, let password = passwordField.text else { return }
        
        let validationStatus = vm.validateLogin(login: login, password: password)
        
        let alertMessage = validationStatus.validate(status: validationStatus)
        let alert = UIAlertController(title: "Login Failed",
                                      message: alertMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        switch validationStatus {
        case .valid:
            view.endEditing(true)
            // to properly hide keyboard
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.vm.performLoggingIn()
            }
        case .invalid, .noData:
            present(alert, animated: true)
        }
    }
    
}


