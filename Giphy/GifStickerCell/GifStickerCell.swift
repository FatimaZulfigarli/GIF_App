//
//  GifStickerCell.swift
//  Giphy
//
//  Created by Fatya on 26.07.24.
//

import UIKit

protocol GifStickerCellConfigurable {
    var imageURL: String? { get }
}

class GifStickerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }

        func configure(with model: GifStickerCellConfigurable) {
            if let url = model.imageURL {
                imageView.loadGif(from: url)
            }
        }
    }
