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
    
    func loginWithEmail(loginData: LoginData, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        Auth.auth().signIn(withEmail: loginData.email, password: loginData.password) { [weak self] authResult, error in
            if let error = error {
                print("Login failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let user = authResult?.user {
                let userProfile = UserProfile(fullname: user.displayName ?? "",
                                              email: user.email,
                                              password: "")
                completion(.success(userProfile))
                
                self?.loadFavoritesAfterLogin()
            }
        }
    }
    
    func loginWithGoogle() {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { result, error in
            if let error = error {
                print("Google Sign-In failed: \(error.localizedDescription)")
                return
            }
            
            if let result = result {
                guard let idToken = result.user.idToken?.tokenString else {
                    print("Failed to get ID token from Google Sign-In")
                    return
                }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: result.user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                    if let error = error {
                        print("Firebase Google Sign-In failed: \(error.localizedDescription)")
                    } else {
                        print("User signed in with Google and authenticated with Firebase")
                        self?.navigateToTabBarController()
                    }
                }
            }
        }
    }
    
    func loadFavoritesAfterLogin() {
        let homeViewModel = HomeViewModel()
        homeViewModel.loadFavoritesFromFirebase {
        }
    }
    
    private func navigateToTabBarController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabNav") as? UITabBarController {
            tabBarController.modalPresentationStyle = .fullScreen
            controller.present(tabBarController, animated: true, completion: nil)
        }
    }
    func registerWithEmail(registrationData: RegistrationData, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        Auth.auth().createUser(withEmail: registrationData.email, password: registrationData.password) { result, error in
            if let error = error {
                print("Registration failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            if let user = result?.user {
                let userProfile = UserProfile(fullname: registrationData.fullname,
                                              email: user.email,
                                              password: registrationData.password)
                completion(.success(userProfile))
            }
        }
    }
    
    enum LoginType {
        case email
        case google
    }
}
