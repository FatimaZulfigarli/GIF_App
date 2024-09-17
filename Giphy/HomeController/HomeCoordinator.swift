//
//  HomeCoordinator.swift
//  Giphy
//
//  Created by Fatya on 17.09.24.
//

import Foundation
import UIKit
class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeController = storyboard.instantiateViewController(withIdentifier: "HomeController") as? HomeController {
            homeController.coordinator = self // Pass reference to the coordinator
            navigationController.pushViewController(homeController, animated: true)
        }
    }
    
    func showDetail(selectedItem: GifStickerCellConfigurable, items: [GifStickerCellConfigurable]) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, selectedItems: items, initialSelectedItem: selectedItem)
        detailCoordinator.start() // Navigate to DetailController
    }
}
