//
//  GifStickerCell.swift
//  Giphy
//
//  Created by Fatya on 26.07.24.
//

import UIKit

class GifStickerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.loadGif(name: "Gif")
    }

}
