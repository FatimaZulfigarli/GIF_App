//
//  ProfilePageCoordinator.swift
//  Giphy
//
//  Created by Fatya on 29.08.24.
//

import UIKit

class ProfilePageCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileController = storyboard.instantiateViewController(withIdentifier: "ProfilePageController") as? ProfilePageController {
            profileController.coordinator = self
            navigationController.pushViewController(profileController, animated: true)
        }
    }
    
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginController = storyboard.instantiateViewController(withIdentifier: "LoginController") as? LoginController {
            navigationController.setViewControllers([loginController], animated: true)
        }
    }
}
