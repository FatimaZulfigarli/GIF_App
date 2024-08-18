//
//  SelectedIemCell.swift
//  Giphy
//
//  Created by Fatya on 16.08.24.
//

import UIKit

class SelectedIemCell: UICollectionViewCell {

    @IBOutlet weak var gifStickerImage: UIImageView!
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
       
       func configure(with item: GifStickerCellConfigurable) {
           // Load the GIF into the UIImageView
           if let imageURL = item.imageURL {
               gifStickerImage.loadGif(from: imageURL)
           }
       }
   }
