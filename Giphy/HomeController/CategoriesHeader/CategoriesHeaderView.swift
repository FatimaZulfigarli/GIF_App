//
//  GiphyCategoriesHeaderView.swift
//  Giphy
//
//  Created by Fatya on 24.07.24.
//

import UIKit

class CategoriesHeaderView: UICollectionReusableView {
    @IBOutlet weak var collection: UICollectionView!
    
    var didSelectCategory: ((ContentType) -> Void)?
    let categories: [ContentType] = [.gif, .sticker, .emoji]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
    }
}

extension CategoriesHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Header cell selected: \(indexPath.item)")
        didSelectCategory?(categories[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        let name = categories[indexPath.item]
        cell.configure(with: name.rawValue) { [weak self] in
            self?.didSelectCategory?(name)
        }
        return cell
    }
}

extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(categories.count), height: collectionView.frame.height)
    }
}
