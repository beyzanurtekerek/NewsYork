//
//  SignupVC.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 22.02.2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupVC: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    private var viewModel = SignupVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel.errorMessage = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert(title: "Error!", message: message)
            }
        }
        
        viewModel.success = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlert(title: "Success", message: "Account created successfully!", completion: {
                    self?.goToLoginScreen()
                })
            }
        }
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }
        viewModel.signUp(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword)
    }
    
    func showAlert(title : String, message : String, completion : (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        })
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToLoginScreen() {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    
    
}
