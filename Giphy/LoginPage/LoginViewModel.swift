//
//  LoginViewModel.swift
//  Giphy
//
//  Created by Fatya on 25.09.24.
//
import Foundation
import FirebaseAuth

class LoginViewModel {
    let loginManager: LoginUseCase = LoginManager()
    
    var loginSuccess: (() -> Void)?
    var loginFailure: ((String) -> Void)?
    var passwordResetSuccess: ((String) -> Void)?
    
    func login(email: String, password: String) {
        loginManager.login(email: email, password: password) { [weak self] success in
            if success {
                self?.loginSuccess?()
            } else {
                self?.loginFailure?("Login failed. Please check your credentials.")
            }
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.loginFailure?("Failed to send password reset email: \(error.localizedDescription)")
            } else {
                // Use a separate closure for password reset success
                self?.passwordResetSuccess?("A password reset link has been sent to your email.")
            }
        }
    }
}
