//
//  LoginAdapter.swift
//  Giphy
//
//  Created by Fatya on 30.08.24.
//


import Foundation
import FirebaseAuth
import GoogleSignIn

class LoginAdapter {
    
    var controller: UIViewController
    var userCompletion: ((UserProfile) -> Void)?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    // Function to handle login with email and password
    func loginWithEmail(loginData: LoginData, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        Auth.auth().signIn(withEmail: loginData.email, password: loginData.password) { [weak self] authResult, error in
            if let error = error {
                print("Login failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Successful login, retrieve user data
            if let user = authResult?.user {
                let userProfile = UserProfile(fullname: user.displayName ?? "",
                                              email: user.email,
                                              password: "")
                completion(.success(userProfile))
            }
        }
    }
    // Function to handle Google Sign-In
    func loginWithGoogle() {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let result = result {
                let fullname = "\(result.user.profile?.name ?? "") \(result.user.profile?.familyName ?? "")"
                let user = UserProfile(fullname: fullname,
                                       email: result.user.profile?.email,
                                       password: "")
                
                self.userCompletion?(user)
                
                // Authenticate with Firebase using the Google credential
                guard let idToken = result.user.idToken?.tokenString else {
                    print("Failed to retrieve ID token")
                    return
                }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: result.user.accessToken.tokenString)
                Auth.auth().signIn(with: credential) { _, error in
                    if let error = error {
                        print("Firebase Google Sign-In failed: \(error.localizedDescription)")
                    } else {
                        print("User signed in with Google and authenticated with Firebase")
                    }
                }
            }
        }
    }
    
    // Function to handle user registration with email and password
    func registerWithEmail(registrationData: RegistrationData, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        Auth.auth().createUser(withEmail: registrationData.email, password: registrationData.password) { result, error in
            if let error = error {
                print("Registration failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Successful registration
            if let user = result?.user {
                let userProfile = UserProfile(fullname: registrationData.fullname,
                                              email: user.email,
                                              password: registrationData.password)
                completion(.success(userProfile))
            }
        }
    }
}

enum LoginType {
    case email
    case google
}
