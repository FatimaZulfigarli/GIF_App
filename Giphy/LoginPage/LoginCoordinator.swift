//
//  LoginCoordinator.swift
//  Giphy
//
//  Created by Fatya on 17.09.24.
//

import Foundation
import UIKit
class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginController = storyboard.instantiateViewController(withIdentifier: "LoginController") as? LoginController {
            loginController.coordinator = self // Pass reference to the coordinator
            navigationController.pushViewController(loginController, animated: true)
        }
    }
    
    func navigateToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start() // Navigate to HomeController
    }
}
