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
        let nib = UINib(nibName: "SelectedIemCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SelectedIemCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configure(with selectedItem: GifStickerCellConfigurable) {
        self.selectedItem = selectedItem
        print("SelectedItemHeader configure called with item: \(selectedItem)")
        collectionView.reloadData()
    }
}

extension SelectedItemHeader: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedItemCell", for: indexPath) as! SelectedItemCell
        if let selectedItem = selectedItem {
            print("Configuring cell with item: \(selectedItem)")
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
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
