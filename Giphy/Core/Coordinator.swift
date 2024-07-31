//
//  Coordinator.swift
//  Giphy
//
//  Created by Fatya on 31.07.24.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
