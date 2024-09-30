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
    @IBOutlet weak var tickButton: UIButton!
    var onRegisterComplete: ((RegistrationData) -> Void)?
    var viewModel: RegisterViewModel? // Reference to the ViewModel
    var coordinator: RegisterCoordinator? // Add this property


    lazy var loginAdapter = LoginAdapter(controller: self)
    private let urlHelper = URLs()

    var isTermsAccepted = false // Track whether terms are accepted

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RegisterController loaded.") // Debugging
        viewModel = RegisterViewModel()
        setupBindings()


        // Do any additional setup after loading the view.
    }
    private func setupBindings() {
            viewModel?.registrationSuccess = { [weak self] registrationData in
                self?.onRegisterComplete?(registrationData)
                self?.navigationController?.popViewController(animated: true)
            }
            
            viewModel?.registrationFailure = { [weak self] errorMessage in
                self?.showAlert(message: errorMessage)
            }
        }
    
    @IBAction func signUpButton(_ sender: Any) {
    
        guard let email = regEmailTextField.text, !email.isEmpty,
                     let password = regPasswordTextField.text, !password.isEmpty,
                     let fullname = regFullnameTextField.text, !fullname.isEmpty else {
                   showAlert(message: "Email, password, or fullname is empty.")
                   return
               }
               
               guard isTermsAccepted else {
                   showAlert(message: "You must accept the Terms of Service to register.")
                   return
               }
               
               let registrationData = RegistrationData(email: email, password: password, fullname: fullname)
               viewModel?.registerUser(registrationData: registrationData)
           }
           // Alert to show messages
//           private func showAlert(message: String) {
//               let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//               alertController.addAction(okAction)
//               present(alertController, animated: true, completion: nil)
//           }
    
    @IBAction func haveAccountButton(_ sender: Any) {
        if let navigationController = self.navigationController {
                    let loginCoordinator = LoginCoordinator(navigationController: navigationController)
                    loginCoordinator.start()
                }
            }
    @IBAction func googleSignIn(_ sender: Any) {
        loginAdapter.loginWithGoogle()
    }
    private func showAlert(message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
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
        urlHelper.callURL(urlType: .googlePrivacyTerms, from: self)
    }
    @IBAction func termsOfService(_ sender: Any) {
        urlHelper.callURL(urlType: .privacyTerms, from: self)
            }
    @IBAction func privacyPolicy(_ sender: Any) {
        urlHelper.callURL(urlType: .privacyTerms, from: self)
    }
   
    @IBAction func tickButtonTapped(_ sender: Any) {
        isTermsAccepted.toggle()
                let imageName = isTermsAccepted ? "checkmark.square.fill" : "square"
                tickButton.setImage(UIImage(systemName: imageName), for: .normal)
            }
}
