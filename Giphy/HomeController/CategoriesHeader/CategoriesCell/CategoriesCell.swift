//
//  CategoriesCell.swift
//  Giphy
//
//  Created by Fatya on 24.07.24.
//

import UIKit

class CategoriesCell: UICollectionViewCell {

    @IBOutlet weak var categoryName: UILabel!
    var didSelectCategory: (() -> Void)?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        func configure(with name: String, didSelectCategory: @escaping () -> Void) {
            self.categoryName.text = name
            self.didSelectCategory = didSelectCategory
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
            didSelectCategory?()
        }
    }
