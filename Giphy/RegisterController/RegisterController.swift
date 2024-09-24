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
    lazy var loginAdapter = LoginAdapter(controller: self)
    private let urlHelper = URLs()

    var isTermsAccepted = false // Track whether terms are accepted

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
               
               guard isTermsAccepted else {
                   showAlert(message: "You must accept the Terms of Service to register.")
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
           
           // Alert to show messages
           private func showAlert(message: String) {
               let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alertController.addAction(okAction)
               present(alertController, animated: true, completion: nil)
           }
    
    @IBAction func haveAccountButton(_ sender: Any) {
        if let navigationController = self.navigationController {
                // Create an instance of LoginCoordinator and start it
                let loginCoordinator = LoginCoordinator(navigationController: navigationController)
                loginCoordinator.start() // This will navigate to the LoginController
            } else {
                print("Navigation controller is nil")
            }
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
        urlHelper.callURL(urlType: .googlePrivacyTerms, from: self)
    }
    @IBAction func termsOfService(_ sender: Any) {
        urlHelper.callURL(urlType: .termsOfService, from: self)
    }
    @IBAction func privacyPolicy(_ sender: Any) {
        urlHelper.callURL(urlType: .privacyTerms, from: self)
    }
   
    @IBAction func tickButtonTapped(_ sender: Any) {
        // Toggle the state
           isTermsAccepted.toggle()

           // Update the appearance of the button (example: change image or text)
           let imageName = isTermsAccepted ? "checkmark.square.fill" : "square"
           
           if let button = sender as? UIButton {
               button.setImage(UIImage(systemName: imageName), for: .normal)
           }

           print("Terms accepted: \(isTermsAccepted)") // Debugging
       }
}
