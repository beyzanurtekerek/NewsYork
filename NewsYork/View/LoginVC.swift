//
//  LogInVC.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 20.02.2025.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitched: UISwitch!
    @IBOutlet weak var signupLinkButton: UIButton!
    @IBOutlet weak var forgotLinkButton: UIButton!
    
    private var eyeButtonForPassword = UIButton(type: .custom)
    
    private var viewModel = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        checkRememberMe()
        addPasswordVisibilityButton()

    }
    
    func setupBindings() {
        viewModel.loginStatus = { [weak self] success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    self?.navigateToTabBar()
                } else {
                    self?.showErrorAlert(message: errorMessage ?? "Login Failed!")
                }
            }
        }
    }
    
    func addPasswordVisibilityButton() {
        eyeButtonForPassword.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButtonForPassword.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        eyeButtonForPassword.tintColor = .systemGray
        passwordTextField.rightView = eyeButtonForPassword
        passwordTextField.rightViewMode = .always
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let eyeImageName = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        eyeButtonForPassword.setImage(UIImage(systemName: eyeImageName), for: .normal)
    }
    
    func checkRememberMe() {
        let savedCredentials = viewModel.checkSavedCredentials()
        if let email = savedCredentials.email, let password = savedCredentials.password {
            emailTextField.text = email
            passwordTextField.text = password
            rememberMeSwitched.isOn = true
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showErrorAlert(message: "Please fill all fields!")
            return
        }
        viewModel.loginUser(email: email, password: password, rememberMe: rememberMeSwitched.isOn)
        self.navigateToTabBar()
    }
    
    func navigateToTabBar() {
        performSegue(withIdentifier: "toTabBarController", sender: nil)
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
