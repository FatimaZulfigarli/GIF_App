////
////  GifStickerCell.swift
////  Giphy
////
////  Created by Fatya on 26.07.24.
////


import UIKit

protocol GifStickerCellConfigurable {
    var imageURL: String? { get }
    var altText: String? { get }
    var id: String? { get }
}

class GifStickerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
  
    
    var onTap: ((String) -> Void)?
    var onFavButtonTap: ((String) -> Void)? // Callback for favorite button tap
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGestures()
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        print("GifStickerCell tapped")
        if let id = imageView.accessibilityIdentifier {
            onTap?(id)
        } else {
            print("No ID found in accessibilityIdentifier")
        }
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
        print("Favorite button tapped")
        if let id = imageView.accessibilityIdentifier {
            onFavButtonTap?(id) // Notify the ViewController
        }
    }
        
        func configure(with model: GifStickerCellConfigurable, onTap: @escaping (String) -> Void, onFavButtonTap: @escaping (String) -> Void) {
            if let url = model.imageURL {
                imageView.loadGif(from: url)
            }
            if let id = model.id {
                imageView.accessibilityIdentifier = id
            }
            self.onTap = onTap
            self.onFavButtonTap = onFavButtonTap
        }
        
        func updateFavButton(isFavorite: Bool) {
            let imageName = isFavorite ? "heart.fill" : "heart" // Use SF Symbols
            favButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

