//
//  DetailCoordinator.swift
//  Giphy
//
//  Created by Fatya on 31.07.24.
//

import Foundation
import UIKit


class DetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailController") as! DetailController
        navigationController.show(controller, sender: nil)
    }
}
