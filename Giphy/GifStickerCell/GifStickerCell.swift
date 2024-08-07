//
//  GifStickerCell.swift
//  Giphy
//
//  Created by Fatya on 26.07.24.
//

import UIKit

protocol GifStickerCellConfigurable {
    var imageURL: String? { get }
    var altText: String? { get }
}

class GifStickerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var onLongPress: ((String) -> Void)?

    override func awakeFromNib() {
           super.awakeFromNib()
           setupLongPressGesture()
       }

    private func setupLongPressGesture() {
           let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
           addGestureRecognizer(longPressGesture)
       }

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
           if gesture.state == .began {
               onLongPress?(imageView.image?.accessibilityIdentifier ?? "")
           }
       }

    func configure(with model: GifStickerCellConfigurable, onLongPress: @escaping (String) -> Void) {
           if let url = model.imageURL {
               imageView.loadGif(from: url)
           }
           if let emojiDatum = model as? EmojiDatum {
               imageView.image?.accessibilityIdentifier = emojiDatum.id
           }
           self.onLongPress = onLongPress
       }
   }
//        }
//
//        func configure(with model: GifStickerCellConfigurable) {
//            if let url = model.imageURL {
//                imageView.loadGif(from: url)
//            }
//        }
//    }

