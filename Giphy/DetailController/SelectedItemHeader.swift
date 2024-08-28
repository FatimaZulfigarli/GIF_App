//
//  SelectedItemHeader.swift
//  Giphy
//
//  Created by Fatya on 13.08.24.
//

import UIKit

class SelectedItemHeader: UICollectionReusableView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var selectedItem: GifStickerCellConfigurable?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            // Register the cell
            let nib = UINib(nibName: "SelectedIemCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "SelectedIemCell")
            
            // Set the dataSource and delegate
            collectionView.dataSource = self
            collectionView.delegate = self
        }
        
        func configure(with selectedItem: GifStickerCellConfigurable) {
            self.selectedItem = selectedItem
            collectionView.reloadData()
        }
    }

    extension SelectedItemHeader: UICollectionViewDataSource, UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1 // Since we only have one selected item to display
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedIemCell", for: indexPath) as! SelectedIemCell
                
                // Configure the cell with the selected item
                if let selectedItem = selectedItem {
                    cell.configure(with: selectedItem)
                }
                
                return cell
            }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Selected item at indexPath: \(indexPath)")
        }
    }

    extension SelectedItemHeader: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Set size for each cell to be the full width and height of the header
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }
