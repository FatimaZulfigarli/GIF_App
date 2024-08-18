//
//  DetailController.swift
//  Giphy
//
//  Created by Fatya on 31.07.24.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedItem: GifStickerCellConfigurable?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            print("DetailController viewDidLoad")
            
            // Register the header
            let headerNib = UINib(nibName: "SelectedItemHeader", bundle: nil)
            collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SelectedItemHeader")
            
            // Register the GifStickerCell
            let cellNib = UINib(nibName: "GifStickerCell", bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: "GifStickerCell")
            
            // Configure the view with the selected item
            configureView()
        }

        private func configureView() {
            // Set title or other UI elements based on selectedItem
            title = selectedItem?.altText ?? "Detail View"
            
            // Reload the collection view to ensure the header is displayed
            collectionView.reloadData()
        }
    }

    extension DetailController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1 // Just returning 1 for now to have something in the collection view
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
            
            // Configure the cell with the selected item
            if let selectedItem = selectedItem {
                cell.configure(with: selectedItem, onTap: { id in
                    print("GifStickerCell tapped with id: \(id)")
                }, onForceTouch: { id in
                    print("GifStickerCell force touched with id: \(id)")
                })
            }
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                print("Attempting to dequeue header...")
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SelectedItemHeader", for: indexPath) as! SelectedItemHeader
                
                // Pass the selected item to the header
                if let selectedItem = selectedItem {
                    headerView.configure(with: selectedItem)
                }
                
                print("Header dequeued successfully")
                return headerView
            }
            fatalError("Unexpected kind")
        }
    }

    extension DetailController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            let screenHeight = UIScreen.main.bounds.height
            let headerHeight = screenHeight / 2
            let size = CGSize(width: collectionView.bounds.width, height: headerHeight)
            print("Reference size for header in section \(section): \(String(describing: size))")
            return size
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Set size for the GifStickerCell
            let screenHeight = UIScreen.main.bounds.height
            let availableHeight = screenHeight / 2 // Adjust as needed
            return CGSize(width: collectionView.bounds.width, height: availableHeight)
        }
    }
