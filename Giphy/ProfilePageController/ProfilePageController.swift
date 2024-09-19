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
    //       private let homeViewModel = HomeViewModel()
    //
    //       override func viewDidLoad() {
    //           super.viewDidLoad()
    //           setupCollectionView()
    //       }
    //
    //       override func viewWillAppear(_ animated: Bool) {
    //           super.viewWillAppear(animated)
    //           loadFavoritesFromFirebase()
    //       }
    //
    //       private func setupCollectionView() {
    //           collectionView.dataSource = self
    //           collectionView.delegate = self
    //           collectionView.register(UINib(nibName: "GifStickerCell", bundle: nil), forCellWithReuseIdentifier: "GifStickerCell")
    //       }
    //   }
    //
    //
    //    private var favoriteItems: [GifStickerCellConfigurable] = []
    //    private let homeViewModel = HomeViewModel()
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        setupCollectionView()
    //    }
    //
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        loadFavoritesFromFirebase()
    //    }
    //
    //    private func setupCollectionView() {
    //        collectionView.dataSource = self
    //        collectionView.delegate = self
    //        collectionView.register(UINib(nibName: "GifStickerCell", bundle: nil), forCellWithReuseIdentifier: "GifStickerCell")
    //    }
    //
    //    private func loadFavoritesFromFirebase() {
    //        homeViewModel.loadFavoritesFromFirebase { [weak self] in
    //            guard let self = self else { return }
    //            self.favoriteItems = self.homeViewModel.favorites.compactMap { id in
    //                print("Fetching item with ID: \(id)")
    //                return self.homeViewModel.fetchItem(by: id)
    //            }
    //            DispatchQueue.main.async {
    //                if self.favoriteItems.isEmpty {
    //                    print("No favorite items found")
    //                } else {
    //                    print("Loaded favorite items: \(self.favoriteItems)")
    //                }
    //                self.collectionView.reloadData()
    //            }
    //        }
    //    }
    //}
    //
    //   extension ProfilePageController: UICollectionViewDataSource, UICollectionViewDelegate {
    //       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //           return favoriteItems.count
    //       }
    //
    //       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
    //           let item = favoriteItems[indexPath.item]
    //           cell.configure(with: item, onTap: { id in
    //               print("Tapped on favorite item with ID: \(id)")
    //           }, onFavButtonTap: { id in
    //               self.homeViewModel.removeFromFavorites(id: id)
    //               self.loadFavoritesFromFirebase()
    //           })
    //           return cell
    //       }
    //
    //       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //           let selectedItem = favoriteItems[indexPath.item]
    //           // Navigate to detail view if needed
    //       }
    //   }
    
    
    //       private func loadFavoritesFromFirebase() {
    //           guard let userId = Auth.auth().currentUser?.uid else {
    //               print("User is not logged in")
    //               return
    //           }
    //
    //           let db = Firestore.firestore()
    //           db.collection("users").document(userId).getDocument { [weak self] document, error in
    //               guard let self = self else { return }
    //               if let error = error {
    //                   print("Failed to load favorites from Firebase: \(error.localizedDescription)")
    //                   return
    //               }
    //
    //               if let document = document, document.exists {
    //                   if let favoriteArray = document.data()?["favorites"] as? [String] {
    //                       self.favoriteItems = favoriteArray.compactMap { id in
    //                           self.homeViewModel.fetchItem(by: id)
    //                       }
    //                       DispatchQueue.main.async {
    //                           self.collectionView.reloadData()
    //                       }
    //                   } else {
    //                       print("Favorites field does not exist or is not a valid format")
    //                   }
    //               } else {
    //                   print("Document does not exist")
    //               }
    //           }
    //       }
    //   }
    
    private var favoriteItems: [GifStickerCellConfigurable] = []
       private let homeViewModel = HomeViewModel()
       var loginCoordinator: LoginCoordinator? // This is used to handle navigation

       override func viewDidLoad() {
           super.viewDidLoad()
           setupCollectionView()
           homeViewModel.fetchTrendingGIFs()
           homeViewModel.fetchTrendingStickers()
           homeViewModel.fetchEmojis()
       }

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           loadFavoritesFromFirebase()
       }

    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        //        do {
        //                   try Auth.auth().signOut()
        //                   // Switch back to LoginController
        //                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                   if let loginController = storyboard.instantiateViewController(withIdentifier: "LoginController") as? LoginController {
        //                       UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: loginController)
        //                       UIApplication.shared.windows.first?.makeKeyAndVisible()
        //                   }
        //               } catch let error {
        //                   print("Error signing out: \(error.localizedDescription)")
        //               }
        //           }
        //
        //           private func setupCollectionView() {
        //               collectionView.dataSource = self
        //               collectionView.delegate = self
        //               collectionView.register(UINib(nibName: "GifStickerCell", bundle: nil), forCellWithReuseIdentifier: "GifStickerCell")
        //           }
        //
        //           private func loadFavoritesFromFirebase() {
        //               guard let userId = Auth.auth().currentUser?.uid else {
        //                   print("User is not logged in")
        //                   return
        //               }
        //
        //               let db = Firestore.firestore()
        //               db.collection("users").document(userId).getDocument { [weak self] document, error in
        //                   guard let self = self else { return }
        //
        //                   if let error = error {
        //                       print("Failed to load favorites from Firebase: \(error.localizedDescription)")
        //                       return
        //                   }
        //
        //                   if let document = document, document.exists {
        //                       if let favoriteArray = document.data()?["favorites"] as? [String] {
        //                           print("Favorites loaded from Firebase: \(favoriteArray)")
        //                           // Fetch each favorite item by ID
        //                           self.favoriteItems = favoriteArray.compactMap { id in
        //                               self.homeViewModel.fetchItem(by: id)
        //                           }
        //                           DispatchQueue.main.async {
        //                               self.collectionView.reloadData()
        //                           }
        //                       } else {
        //                           print("Favorites field does not exist or is not a valid format in the document")
        //                       }
        //                   } else {
        //                       print("Document does not exist or was not retrieved")
        //                   }
        //               }
        //           }
        //       }
        //
        //       extension ProfilePageController: UICollectionViewDataSource, UICollectionViewDelegate {
        //
        //           func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //               return favoriteItems.count
        //           }
        //
        //           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
        //               let item = favoriteItems[indexPath.item]
        //               // Hide the favorite button when configuring the cell
        //               cell.configure(with: item, showFavButton: false, onTap: { id in
        //                   print("Tapped on favorite item with ID: \(id)")
        //               }, onFavButtonTap: { id in
        //                   self.homeViewModel.removeFromFavorites(id: id)
        //                   self.loadFavoritesFromFirebase()  // Reload favorites after removing one
        //               })
        //               return cell
        //           }
        //
        ////           func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ////               print("Selected favorite item at indexPath: \(indexPath)")
        ////               let selectedItem = favoriteItems[indexPath.item]
        ////               // Navigate to detail view if needed
        ////           }
        //       }
        
        do {
                         try Auth.auth().signOut()
                         // Switch back to LoginController
                         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                         if let loginController = storyboard.instantiateViewController(withIdentifier: "LoginController") as? LoginController {
                             UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: loginController)
                             UIApplication.shared.windows.first?.makeKeyAndVisible()
                         }
                     } catch let error {
                         print("Error signing out: \(error.localizedDescription)")
                     }
                 }
                 
                 private func setupCollectionView() {
                     collectionView.dataSource = self
                     collectionView.delegate = self
                     collectionView.register(UINib(nibName: "GifStickerCell", bundle: nil), forCellWithReuseIdentifier: "GifStickerCell")
                 }
                 
                 private func loadFavoritesFromFirebase() {
                     guard let userId = Auth.auth().currentUser?.uid else {
                         print("User is not logged in")
                         return
                     }
                     
                     let db = Firestore.firestore()
                     db.collection("users").document(userId).getDocument { [weak self] document, error in
                         guard let self = self else { return }
                         
                         if let error = error {
                             print("Failed to load favorites from Firebase: \(error.localizedDescription)")
                             return
                         }
                         
                         if let document = document, document.exists {
                             if let favoriteArray = document.data()?["favorites"] as? [String] {
                                 print("Favorites loaded from Firebase: \(favoriteArray)")
                                 // Fetch each favorite item by ID
                                 self.favoriteItems = favoriteArray.compactMap { id in
                                     self.homeViewModel.fetchItem(by: id)
                                 }
                                 DispatchQueue.main.async {
                                     self.collectionView.reloadData()
                                 }
                             } else {
                                 print("Favorites field does not exist or is not a valid format in the document")
                             }
                         } else {
                             print("Document does not exist or was not retrieved")
                         }
                     }
                 }
             }

extension ProfilePageController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifStickerCell", for: indexPath) as! GifStickerCell
        let item = favoriteItems[indexPath.item]
        // Hide the favorite button when configuring the cell
        cell.configure(with: item, showFavButton: false, onTap: { id in
            print("Tapped on favorite item with ID: \(id)")
        }, onFavButtonTap: { id in
            self.homeViewModel.removeFromFavorites(id: id)
            self.loadFavoritesFromFirebase()  // Reload favorites after removing one
        })
        return cell
    }
}
