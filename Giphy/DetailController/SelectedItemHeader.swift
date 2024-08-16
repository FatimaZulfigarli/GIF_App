//
//  SelectedItemHeader.swift
//  Giphy
//
//  Created by Fatya on 13.08.24.
//

import UIKit

class SelectedItemHeader: UICollectionReusableView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
       override func awakeFromNib() {
           super.awakeFromNib()
           
           
           // Register the cell
           let nib = UINib(nibName: "SelectedIemCell", bundle: nil)
           collectionView.register(nib, forCellWithReuseIdentifier: "SelectedIemCell")
           
           // Set the dataSource and delegate
           collectionView.dataSource = self
           collectionView.delegate = self
       }
   }

   extension SelectedItemHeader: UICollectionViewDataSource, UICollectionViewDelegate {
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 5 // Example: Returning 5 items for demonstration
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedIemCell", for: indexPath) as! SelectedIemCell
           
           return cell
       }
       
       // Add this method to handle item selection if needed
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("Selected item at indexPath: \(indexPath)")
       }
   }

   extension SelectedItemHeader: UICollectionViewDelegateFlowLayout {
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Set size for each cell
           return CGSize(width: 100, height: 100)
       }
   }
