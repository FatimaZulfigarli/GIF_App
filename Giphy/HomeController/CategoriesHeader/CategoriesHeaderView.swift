//
//  GiphyCategoriesHeaderView.swift
//  Giphy
//
//  Created by Fatya on 24.07.24.
//

import UIKit

class CategoriesHeaderView: UICollectionReusableView {

    @IBOutlet weak var collection: UICollectionView!
    var didSelectCategory: ((Int) -> Void)?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            collection.dataSource = self
            collection.delegate = self
            collection.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
        }
    }

    extension CategoriesHeaderView: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2 // Adjust according to your data
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
            let name = indexPath.item == 0 ? "Gif" : "Sticker"
            cell.configure(with: name) { [weak self] in
                self?.didSelectCategory?(indexPath.item)
            }
            return cell
        }
    }

    extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
        }
    }
