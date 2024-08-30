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
            print("Email, password, or fullname is empty")  // Debugging
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
                        print("Registration failed: \(error.localizedDescription)")
                    }
                }
            }
    
    
    @IBAction func haveAccountButton(_ sender: Any) {
    }
    @IBAction func googleSignIn(_ sender: Any) {
        loginAdapter.loginWithGoogle()
            
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
