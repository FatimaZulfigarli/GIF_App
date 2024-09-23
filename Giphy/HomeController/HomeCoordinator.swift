//
//  HomeCoordinator.swift
//  Giphy
//
//  Created by Fatya on 17.09.24.
//

import Foundation
import UIKit
//class HomeCoordinator: Coordinator {
//    var navigationController: UINavigationController
//        
//        init(navigationController: UINavigationController) {
//            self.navigationController = navigationController
//        }
//        
//        func start() {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let homeController = storyboard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
//                homeController.coordinator = self // Pass reference to the coordinator
//                navigationController.pushViewController(homeController, animated: true)
//            }
//        }
//        
//        // Navigate to ProfilePageController and pass the LoginCoordinator
//        func showProfile() {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let profilePageController = storyboard.instantiateViewController(withIdentifier: "ProfilePageController") as? ProfilePageController {
//                // Pass the LoginCoordinator to ProfilePageController
//                profilePageController.loginCoordinator = LoginCoordinator(navigationController: navigationController)
//                navigationController.pushViewController(profilePageController, animated: true)
//            }
//        }
//        
//        func showDetail(selectedItem: GifStickerCellConfigurable, items: [GifStickerCellConfigurable]) {
//            let detailCoordinator = DetailCoordinator(navigationController: navigationController, selectedItems: items, initialSelectedItem: selectedItem)
//            detailCoordinator.start() // Navigate to DetailController
//        }
//    }

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeController = storyboard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
            homeController.coordinator = self
            navigationController.pushViewController(homeController, animated: true)
        }
    }
    
    // Navigate to ProfilePageController and pass the LoginCoordinator
//    func showProfile() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let profilePageController = storyboard.instantiateViewController(withIdentifier: "ProfilePageController") as? ProfilePageController {
//            // Create and pass the LoginCoordinator
//            let loginCoordinator = LoginCoordinator(navigationController: navigationController)
//            profilePageController.loginCoordinator = loginCoordinator
//            navigationController.pushViewController(profilePageController, animated: true)
//        }
//    }
    
    func showDetail(selectedItem: GifStickerCellConfigurable, items: [GifStickerCellConfigurable]) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, selectedItems: items, initialSelectedItem: selectedItem)
        detailCoordinator.start() // Navigate to DetailController
    }
}
