//
//  LoginVM.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 22.02.2025.
//

import Foundation
import FirebaseAuth

class LoginVM {
    
    var loginStatus : ((Bool, String?) -> Void)?
    
    func loginUser(email : String, password : String, rememberMe : Bool) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.loginStatus?(false, error.localizedDescription)
            } else {
                if rememberMe {
                    UserDefaults.standard.set(email, forKey: "savedEmail")
                    UserDefaults.standard.set(password, forKey: "savedPassword")
                }
                self.loginStatus?(true, nil)
            }
        }
    }
    
    func checkSavedCredentials() -> (email : String?, password : String?) {
        let email = UserDefaults.standard.string(forKey: "savedEmail")
        let password = UserDefaults.standard.string(forKey: "savedPassword")
        return (email, password)
    }
    
}
