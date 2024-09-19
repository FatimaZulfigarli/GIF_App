//
//  LoginController.swift
//  Giphy
//
//  Created by Fatya on 26.08.24.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    var coordinator: LoginCoordinator? // Reference to the LoginCoordinator

    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var giphyLabel: UILabel!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    lazy var loginAdapter = LoginAdapter(controller: self)
    private let urlHelper = URLs()


    override func viewDidLoad() {
        super.viewDidLoad()
        loginAdapter.userCompletion = { [weak self] userProfile in
                   guard let self = self else { return }
                   
                   print("Logged in as: \(userProfile.fullname)")
                   print("Email: \(userProfile.email ?? "No email found")")
                   
                   self.navigateToMainApp()
               }
           }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = loginEmailTextField.text, !email.isEmpty,
                  let password = loginPasswordTextField.text, !password.isEmpty else {
                showAlert(message: "Email or password is missing.")
                return
            }
            
            let loginData = LoginData(email: email, password: password)
            loginAdapter.loginWithEmail(loginData: loginData) { [weak self] result in
                switch result {
                case .success(let userProfile):
                    self?.navigateToMainApp()
                case .failure(let error):
                    self?.showAlert(message: "Login failed: \(error.localizedDescription)")
                }
            }
        }

        private func showAlert(message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
    
    @IBAction func signupButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let registerController = storyboard.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController {
                   
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
        print("clicking termsofservice")
        urlHelper.callURL(urlType: .termsOfService, from: self)
                print("Terms of Service clicked")
            }
   
  
    
    
    @IBAction func privacyPolicy(_ sender: Any) {
        urlHelper.callURL(urlType: .privacyTerms, from: self)
                print("Privacy Policy clicked")
            }
    
    
    
    
    
    /*
    // MARK: - Navigation

     @IBAction func privacyPolicy(_ sender: Any) {
     }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func navigateToMainApp() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabNav") as? UITabBarController {
               tabBarController.modalPresentationStyle = .fullScreen
               self.present(tabBarController, animated: true, completion: nil)
           }
       }
   }


