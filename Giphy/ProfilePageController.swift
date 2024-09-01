//
//  ProfilePageController.swift
//  Giphy
//
//  Created by Fatya on 29.08.24.
//

import UIKit
import Firebase
import FirebaseAuth
class ProfilePageController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var favoriteItems: [GifStickerCellConfigurable] = [] // Array to store favorite items
    private let homeViewModel = HomeViewModel() // Use the existing HomeViewModel for fetching favorites
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()  // Setup the collection view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoritesFromFirebase() // Load favorites every time the view appears
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GifStickerCell", bundle: nil), forCellWithReuseIdentifier: "GifStickerCell")
    }
    
    private func loadFavoritesFromFirebase() {
        homeViewModel.loadFavoritesFromFirebase { [weak self] in
            guard let self = self else { return }
//            self.favoriteItems = self.homeViewModel.favorites.compactMap { id in
//                let item = self.homeViewModel.fetchItem(by: id)
//                if item == nil {
//                    print("No item found for ID \(id)")
//                } else {
//                    print("Fetched item for ID \(id): \(item!)")
//                }
//                return item
//            }
            DispatchQueue.main.async {
                print("Loaded favorite items: \(self.favoriteItems)")
                self.collectionView.reloadData()  // Refresh collection view
                print("Reloading collection view with \(self.favoriteItems.count) items")
            }
        }
    }
}

extension ProfilePageController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = favoriteItems.count
        print("Number of items in section: \(count)")
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
        let item = favoriteItems[indexPath.item]
        cell.configure(with: item, onTap: { id in
            print("Tapped on favorite item with ID: \(id)")
        }, onFavButtonTap: { id in
            print("Favorite button tapped for favorite item with ID: \(id)")
            self.homeViewModel.removeFromFavorites(id: id)
            self.loadFavoritesFromFirebase()  // Reload favorites after removing one
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected favorite item at indexPath: \(indexPath)")
        let selectedItem = favoriteItems[indexPath.item]
        // Navigate to detail view if needed
    }
}
