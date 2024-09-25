//
//  RegisterCoordinator.swift
//  Giphy
//
//  Created by Fatya on 25.09.24.
//

import Foundation
import UIKit

class RegisterCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let registerController = storyboard.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController {
            registerController.coordinator = self
            navigationController.pushViewController(registerController, animated: true)
        }
    }
}
