//
//  RegisterController.swift
//  Giphy
//
//  Created by Fatya on 26.08.24.
//

import UIKit
import FirebaseAuth

class RegisterController: UIViewController {

    @IBOutlet weak var regFullnameTextField: UITextField!
    
    @IBOutlet weak var regEmailTextField: UITextField!
    
    @IBOutlet weak var regPasswordTextField: UITextField!
    var onRegisterComplete: ((RegistrationData) -> Void)?
    lazy var loginAdapter = LoginAdapter(controller: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RegisterController loaded.") // Debugging


        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    
        print("Register button tapped")  // Debugging
           
           guard let email = regEmailTextField.text, !email.isEmpty,
                 let password = regPasswordTextField.text, !password.isEmpty,
                 let fullname = regFullnameTextField.text, !fullname.isEmpty else {
               showAlert(message: "Email, password, or fullname is empty.")
               return
           }
           
           let registrationData = RegistrationData(email: email, password: password, fullname: fullname)
           print("Attempting to create user with email: \(email)")  // Debugging
           
           loginAdapter.registerWithEmail(registrationData: registrationData) { [weak self] result in
               switch result {
               case .success(let userProfile):
                   print("User registered: \(userProfile.fullname)")
                   self?.onRegisterComplete?(registrationData)
                   self?.navigationController?.popViewController(animated: true)
               case .failure(let error):
                   self?.showAlert(message: "Registration failed: \(error.localizedDescription)")
               }
           }
       }

       private func showAlert(message: String) {
           let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
    
    
    @IBAction func haveAccountButton(_ sender: Any) {
    }
    @IBAction func googleSignIn(_ sender: Any) {
        loginAdapter.userCompletion = { [weak self] userProfile in
                   guard let self = self else { return }
                   print("Google Sign-In successful for user: \(userProfile.fullname)")
                   
                   // Automatically navigate to the main app screen after Google Sign-In
                   self.navigateToMainApp()
               }
               
               // Trigger Google Sign-In
               loginAdapter.loginWithGoogle()
           }
           
           private func navigateToMainApp() {
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabNav") as? UITabBarController {
                   tabBarController.modalPresentationStyle = .fullScreen
                   self.present(tabBarController, animated: true, completion: nil)
               } else if let homeController = storyboard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
                   homeController.modalPresentationStyle = .fullScreen
                   self.present(homeController, animated: true, completion: nil)
               }
           }
       
   
    @IBAction func googlePrivacy(_ sender: Any) {
    }
    @IBAction func termsOfService(_ sender: Any) {
    }
    @IBAction func privacyPolicy(_ sender: Any) {
    }
    @IBAction func tickButton(_ sender: Any) {
    }
}
