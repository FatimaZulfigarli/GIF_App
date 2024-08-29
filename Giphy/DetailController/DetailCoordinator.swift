//
//  DetailCoordinator.swift
//  Giphy
//
//  Created by Fatya on 31.07.24.
//

import Foundation
import UIKit


//class DetailCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    var selectedItem: GifStickerCellConfigurable?
//
//    init(navigationController: UINavigationController, selectedItem: GifStickerCellConfigurable?) {
//        self.navigationController = navigationController
//        self.selectedItem = selectedItem
//    }
//    
//    func start() {
//        print("DetailCoordinator start() called with item id: \(selectedItem?.id ?? "unknown")")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let controller = storyboard.instantiateViewController(withIdentifier: "DetailController") as? DetailController {
//            controller.selectedItem = selectedItem
//            print("DetailController instantiated with selectedItem: \(selectedItem?.id ?? "unknown")")
//            navigationController.pushViewController(controller, animated: true)
//            print("DetailController pushed onto navigation stack")
//        } else {
//            print("Failed to instantiate DetailController from storyboard")
//        }
//    }
//}


// DetailCoordinator.swift

class DetailCoordinator {
    private let navigationController: UINavigationController
    private let selectedItems: [GifStickerCellConfigurable]
    private let initialSelectedItem: GifStickerCellConfigurable

    init(navigationController: UINavigationController, selectedItems: [GifStickerCellConfigurable], initialSelectedItem: GifStickerCellConfigurable) {
        self.navigationController = navigationController
        self.selectedItems = selectedItems
        self.initialSelectedItem = initialSelectedItem
    }

    func start() {
        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailController") as! DetailController
        detailController.selectedItems = selectedItems
        detailController.initialSelectedItem = initialSelectedItem // Pass initial selected item
        navigationController.pushViewController(detailController, animated: true)
    }
}

//class DetailCoordinator {
//    private let navigationController: UINavigationController
//    private let selectedItems: [GifStickerCellConfigurable]
//    
//    init(navigationController: UINavigationController, selectedItems: [GifStickerCellConfigurable]) {
//        self.navigationController = navigationController
//        self.selectedItems = selectedItems
//    }
//    
//    func start() {
//        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailController") as! DetailController
//        detailController.selectedItems = selectedItems
//        navigationController.pushViewController(detailController, animated: true)
//    }
//}
