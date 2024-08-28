//
//  LoginController.swift
//  Giphy
//
//  Created by Fatya on 26.08.24.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var giphyLabel: UILabel!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = loginEmailTextField.text, !email.isEmpty,
                     let password = loginPasswordTextField.text, !password.isEmpty else {
                   print("Email or password is missing")
                   return
               }
               
               Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                   if let error = error {
                       print("Login failed: \(error.localizedDescription)")
                       return
                   }
                   
                   // Login successful, navigate to the main view controller
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
                       self?.navigationController?.show(viewController, sender: nil)
                   }
               }
           }
    @IBAction func signupButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let registerController = storyboard.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController {
                   
                   // Set the callback to update the email and password fields
                   registerController.onRegisterComplete = { [weak self] registrationData in
                       self?.loginEmailTextField.text = registrationData.email
                       self?.loginPasswordTextField.text = registrationData.password
                       print("Email: \(registrationData.email), Password: \(registrationData.password)")
                   }
                   
                   self.navigationController?.pushViewController(registerController, animated: true)
               }
           }
    @IBAction func forgetPasswordButton(_ sender: Any) {
    }
    @IBAction func termsOfService(_ sender: Any) {
    }
    
    @IBAction func privacyPolicy(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
