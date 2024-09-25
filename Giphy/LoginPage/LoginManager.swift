//
//  LoginManager.swift
//  Giphy
//
//  Created by Fatya on 25.09.24.
//

import Foundation
import FirebaseAuth

class LoginManager: LoginUseCase {
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let _ = authResult {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
