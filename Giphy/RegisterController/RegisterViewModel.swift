//
//  RegisterViewModel.swift
//  Giphy
//
//  Created by Fatya on 25.09.24.
//

import Foundation

class RegisterViewModel {
    let registerManager: RegisterUseCase = RegisterManager()
    
    var registrationSuccess: ((RegistrationData) -> Void)?
    var registrationFailure: ((String) -> Void)?
    
    func registerUser(registrationData: RegistrationData) {
        registerManager.register(email: registrationData.email, password: registrationData.password, fullname: registrationData.fullname) { [weak self] result in
            switch result {
            case .success(let registrationData):
                self?.registrationSuccess?(registrationData)
            case .failure(let error):
                self?.registrationFailure?("Registration failed: \(error.localizedDescription)")
            }
        }
    }
    
    func signInWithGoogle() {
        // Handle Google Sign-In logic
        registerManager.signInWithGoogle { [weak self] result in
            switch result {
            case .success(let userProfile):
                // Handle Google Sign-In success
                print("Google Sign-In successful: \(userProfile.fullname)")
                // Navigate to the main app after sign-in, or handle it accordingly
            case .failure(let error):
                self?.registrationFailure?("Google Sign-In failed: \(error.localizedDescription)")
            }
        }
    }
}
