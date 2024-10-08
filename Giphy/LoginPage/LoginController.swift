//
//  LoginController.swift
//  Giphy
//
//  Created by Fatya on 26.08.24.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    var coordinator: LoginCoordinator? 
    var viewModel: LoginViewModel?

    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var giphyLabel: UILabel!
    
    @IBOutlet weak var loginPasswordTextField: UITextField!
    lazy var loginAdapter = LoginAdapter(controller: self)
    private let urlHelper = URLs()


    override func viewDidLoad() {
            super.viewDidLoad()
            viewModel = LoginViewModel()
            setupBindings()
        }
        
        private func setupBindings() {
            viewModel?.loginSuccess = { [weak self] in
                self?.navigateToMainApp()
            }
            
            viewModel?.loginFailure = { [weak self] errorMessage in
                self?.showAlert(message: errorMessage)
            }

            viewModel?.passwordResetSuccess = { [weak self] successMessage in
                // Show success message without navigating to Home
                self?.showAlert(message: successMessage)
            }
        }
    @IBAction func loginButton(_ sender: Any) {
        guard let email = loginEmailTextField.text, !email.isEmpty,
                      let password = loginPasswordTextField.text, !password.isEmpty else {
                    showAlert(message: "Email or password is missing.")
                    return
                }
                viewModel?.login(email: email, password: password)
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
                    }
                    self.navigationController?.pushViewController(registerController, animated: true)
                }
            }
    
    @IBAction func forgetPasswordButton(_ sender: Any) {
        guard let email = loginEmailTextField.text, !email.isEmpty else {
                    showAlert(message: "Please enter your email address.")
                    return
                }
                viewModel?.resetPassword(email: email)
            }
            
    @IBAction func termsOfService(_ sender: Any) {
        urlHelper.callURL(urlType: .termsOfService, from: self)
                print("Terms of Service clicked")
            }
    
    @IBAction func privacyPolicy(_ sender: Any) {
        urlHelper.callURL(urlType: .privacyTerms, from: self)
                print("Privacy Policy clicked")
            }
    
    private func navigateToMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabNav") as? UITabBarController {
                   tabBarController.modalPresentationStyle = .fullScreen
                   self.present(tabBarController, animated: true, completion: nil)
               }
           }
       }

