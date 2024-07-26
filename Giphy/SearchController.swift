//
//  SearchController.swift
//  Giphy
//
//  Created by Fatya on 24.07.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout
class SearchController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = 2
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerHeight = 44
        layout.footerHeight = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemRenderDirection = .shortestFirst

        collection.collectionViewLayout = layout
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "GifStickerCell", bundle: nil), forCellWithReuseIdentifier: "GifStickerCell")
        collection.register(UINib(nibName: "\(CategoriesHeaderView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(CategoriesHeaderView.self)")
    }
}

extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12 // Adjust according to your data
    }
    
    func collectionView(_ collection: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
        // Configure your cell with data
        cell.imageView.backgroundColor = .red // Placeholder for actual image
        
        // Example to demonstrate different images for GIF and Sticker
        if indexPath.item % 2 == 0 {
            cell.imageView.image = UIImage(named: "Gif")
        } else {
            cell.imageView.image = UIImage(named: "Gif")
        }
        
        return cell
    }

    func collectionView(_ collection: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CategoriesHeaderView.self)", for: indexPath) as! CategoriesHeaderView
            // Configure the header if needed
            return header
        }
        return UICollectionReusableView()
    }
}

extension SearchController: UICollectionViewDelegate {
    func collectionView(_ collection: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle cell selection
    }
}

extension SearchController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the original size of the item
        // You can adjust the sizes as needed. Here, random heights are used as an example.
        let width = (collectionView.bounds.width - 30) / 2 // Adjust the number 30 to match your spacing
        let height = CGFloat(arc4random_uniform(100) + 100)
        return CGSize(width: width, height: height)
    }
}
