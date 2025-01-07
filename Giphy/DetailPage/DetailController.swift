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
    var gifItems: [GifStickerCellConfigurable] = []
    var initialSelectedItem: GifStickerCellConfigurable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DetailController viewDidLoad")
        
        let headerNib = UINib(nibName: "SelectedItemHeader", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SelectedItemHeader")
        
        let cellNib = UINib(nibName: "GifStickerCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "GifStickerCell")
        
        loadItems()
        configureView()
    }
    
    private func loadItems() {
        gifItems = selectedItems
        collectionView.reloadData()
    }
    
    private func configureView() {
        title = initialSelectedItem?.altText ?? "Detail View"
        
        collectionView.reloadData()
    }
}

extension DetailController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
        let item = gifItems[indexPath.item]
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
            if let initialSelectedItem = initialSelectedItem {
                
                headerView.configure(with: initialSelectedItem) 
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
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        let height = CGFloat(150)
        return CGSize(width: width, height: height)
    }
}
