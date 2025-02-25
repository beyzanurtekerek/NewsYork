//
//  SignupVM.swift
//  NewsYork
//
//  Created by Beyza Nur Tekerek on 24.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignupVM {
     
    var errorMessage : ((String) -> Void)?
    var success : (() -> Void)?
    
    func signUp(firstName : String, lastName : String, email : String, password : String, confirmPassword : String) {
        
        guard password == confirmPassword else {
            errorMessage?("Passwords do not match!")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage?(error.localizedDescription)
                return
            }
            
            guard let userID = authResult?.user.uid else { return }
            let user = SignupModel(firstName: firstName, lastName: lastName, email: email)
            let db = Firestore.firestore()
            
            db.collection("users").document(userID).setData([
                "firstName" : user.firstName,
                "lastName"  : user.lastName,
                "email"     : user.email
            ]) { error in
                if let error = error {
                    self.errorMessage?(error.localizedDescription)
                } else {
                    self.success?()
                }
            }
        }
    }
    
}
