////
////  GifStickerCell.swift
////  Giphy
////
////  Created by Fatya on 26.07.24.
////
//
//import UIKit
//
//protocol GifStickerCellConfigurable {
//    var imageURL: String? { get }
//    var altText: String? { get }
//    var id: String? { get }
//
//}
//
//class GifStickerCell: UICollectionViewCell {
//    @IBOutlet weak var imageView: UIImageView!
//    var onTap: ((String) -> Void)?
//        var onForceTouch: ((String) -> Void)?
//        private var previewInteraction: UIPreviewInteraction?
//
//        override func awakeFromNib() {
//            super.awakeFromNib()
//            setupGestures()
//        }
//
//    private func setupGestures() {
//         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//         addGestureRecognizer(tapGesture)
//
//         if #available(iOS 13.0, *) {
//             let interaction = UIContextMenuInteraction(delegate: self)
//             addInteraction(interaction)
//         } else {
//             previewInteraction = UIPreviewInteraction(view: self)
//             previewInteraction?.delegate = self
//         }
//     }
//
//    @objc private func handleTap() {
//        print("GifStickerCell tapped")
//        if let id = imageView.accessibilityIdentifier {
//            onTap?(id)
//        } else {
//            print("No ID found in accessibilityIdentifier")
//        }
//    }
//
////    func configure(with model: GifStickerCellConfigurable, onTap: @escaping (String) -> Void, onForceTouch: @escaping (String) -> Void) {
////        if let url = model.imageURL {
////            imageView.loadGif(from: url)
////        }
////        if let id = model.id {
////            print("Setting accessibilityIdentifier with id: \(id)")
////            imageView.accessibilityIdentifier = id
////        } else {
////            print("Warning: Model id is nil")
////        }
////        self.onTap = onTap
////        self.onForceTouch = onForceTouch
////        print("GifStickerCell configured with id: \(model.id ?? "unknown")")
////    }
//    
//    func configure(with model: GifStickerCellConfigurable, onTap: @escaping (String) -> Void, onForceTouch: @escaping (String) -> Void) {
//        if let url = model.imageURL {
//            imageView.loadGif(from: url)
//        }
//        if let id = model.id {
//            imageView.accessibilityIdentifier = id
//        }
//        self.onTap = onTap
//        self.onForceTouch = onForceTouch
//    }
//}
//
//    extension GifStickerCell: UIPreviewInteractionDelegate {
//        func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
//            if ended {
//                onForceTouch?(imageView.image?.accessibilityIdentifier ?? "")
//            }
//        }
//
//        func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {}
//    }
//
//    @available(iOS 13.0, *)
//    extension GifStickerCell: UIContextMenuInteractionDelegate {
//        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
//                let action = UIAction(title: "View Variations") { [weak self] _ in
//                    self?.onForceTouch?(self?.imageView.image?.accessibilityIdentifier ?? "")
//                }
//                return UIMenu(title: "", children: [action])
//            }
//        }
//    }

import UIKit

protocol GifStickerCellConfigurable {
    var imageURL: String? { get }
    var altText: String? { get }
    var id: String? { get }
}

class GifStickerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var onTap: ((String) -> Void)?
       var onForceTouch: ((String) -> Void)?
       private var previewInteraction: UIPreviewInteraction?

       override func awakeFromNib() {
           super.awakeFromNib()
           setupGestures()
       }

       private func setupGestures() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           addGestureRecognizer(tapGesture)

           if #available(iOS 13.0, *) {
               let interaction = UIContextMenuInteraction(delegate: self)
               addInteraction(interaction)
           } else {
               previewInteraction = UIPreviewInteraction(view: self)
               previewInteraction?.delegate = self
           }
       }

       @objc private func handleTap() {
           print("GifStickerCell tapped")
           if let id = imageView.accessibilityIdentifier {
               onTap?(id)
           } else {
               print("No ID found in accessibilityIdentifier")
           }
       }

       func configure(with model: GifStickerCellConfigurable, onTap: @escaping (String) -> Void, onForceTouch: @escaping (String) -> Void) {
           if let url = model.imageURL {
               imageView.loadGif(from: url)
           }
           if let id = model.id {
               imageView.accessibilityIdentifier = id
           }
           self.onTap = onTap
           self.onForceTouch = onForceTouch
       }
   }

   extension GifStickerCell: UIPreviewInteractionDelegate {
       func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
           if ended {
               onForceTouch?(imageView.image?.accessibilityIdentifier ?? "")
           }
       }

       func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {}
   }

   @available(iOS 13.0, *)
   extension GifStickerCell: UIContextMenuInteractionDelegate {
       func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
           return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
               let action = UIAction(title: "View Variations") { [weak self] _ in
                   self?.onForceTouch?(self?.imageView.image?.accessibilityIdentifier ?? "")
               }
               return UIMenu(title: "", children: [action])
           }
       }
   }
