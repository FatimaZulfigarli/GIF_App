//
//  DetailCoordinator.swift
//  Giphy
//
//  Created by Fatya on 31.07.24.
//

import Foundation
import UIKit

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
