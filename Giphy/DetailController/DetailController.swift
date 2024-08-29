//
//  DetailController.swift
//  Giphy
//
//  Created by Fatya on 31.07.24.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedItems: [GifStickerCellConfigurable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DetailController viewDidLoad")
        
        // Register the header
        let headerNib = UINib(nibName: "SelectedItemHeader", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SelectedItemHeader")
        
        // Register the GifStickerCell
        let cellNib = UINib(nibName: "GifStickerCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "GifStickerCell")
        
        // Configure the view with the selected items
        configureView()
    }
    
    private func configureView() {
        // Set the title based on the first selected item or provide a default title
        title = selectedItems.first?.altText ?? "Detail View"
        
        // Reload the collection view to display the items
        collectionView.reloadData()
    }
}

extension DetailController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
        let item = selectedItems[indexPath.item]
        cell.configure(with: item, onTap: { id in
            print("Tapped on item with ID: \(id)")
        }, onFavButtonTap: { id in
            print("Favorite button tapped for item with ID: \(id)")
        })
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SelectedItemHeader", for: indexPath) as! SelectedItemHeader
            if let firstItem = selectedItems.first {
                print("Configuring header with item: \(firstItem)")
                headerView.configure(with: firstItem) // Pass the correct selected item
            }
            return headerView
        }
        return UICollectionReusableView()
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
        let width = (collectionView.bounds.width - 30) / 2
        let height = CGFloat(arc4random_uniform(100) + 100)
        return CGSize(width: width, height: height)
    }
}
