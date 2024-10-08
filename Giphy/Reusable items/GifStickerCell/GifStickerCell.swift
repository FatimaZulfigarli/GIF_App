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
    var onFavButtonTap: ((String) -> Void)?
    
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
            //Check if the current button is filled or not
            let isCurrentlyFavorited = favButton.image(for: .normal) == UIImage(systemName: "heart.fill")
            
            //  Toggle the button UI immediately
            let newImageName = isCurrentlyFavorited ? "heart" : "heart.fill"
            favButton.setImage(UIImage(systemName: newImageName), for: .normal)
            
            // Call the callback to update the favorites in the ViewController
            onFavButtonTap?(id)
        }
    }
    
    
    
    func configure(with model: GifStickerCellConfigurable, showFavButton: Bool = true, onTap: @escaping (String) -> Void, onFavButtonTap: @escaping (String) -> Void) {
        if let url = model.imageURL {
            imageView.loadGif(from: url)
        }
        if let id = model.id {
            imageView.accessibilityIdentifier = id
        }
        self.onTap = onTap
        self.onFavButtonTap = onFavButtonTap
        
        // Show or hide the favorite button based on the flag
        favButton.isHidden = !showFavButton
    }
    
    func updateFavButton(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart" 
        favButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

