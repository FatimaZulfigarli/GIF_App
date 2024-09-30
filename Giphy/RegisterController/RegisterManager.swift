//
//  RegisterManager.swift
//  Giphy
//
//  Created by Fatya on 25.09.24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

class RegisterManager: RegisterUseCase {
    
    func register(email: String, password: String, fullname: String, completion: @escaping (Result<RegistrationData, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let user = authResult?.user {
                let registrationData = RegistrationData(email: email, password: password, fullname: fullname)
                completion(.success(registrationData))
            }
        }
    }
    
    func signInWithGoogle(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.windows.first?.rootViewController ?? UIViewController()) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                let fullname = "\(result.user.profile?.name ?? "") \(result.user.profile?.familyName ?? "")"
                let userProfile = UserProfile(fullname: fullname, email: result.user.profile?.email, password: "")

                // Authenticate with Firebase using the Google credential
                guard let idToken = result.user.idToken?.tokenString else {
                    completion(.failure(NSError(domain: "GoogleSignIn", code: -1, userInfo: nil)))
                    return
                }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: result.user.accessToken.tokenString)

                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(userProfile))
                    }
                }
            }
        }
    }
}
