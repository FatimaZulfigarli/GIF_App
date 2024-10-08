//
//  ProfileManager.swift
//  Giphy
//
//  Created by Fatya on 08.10.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProfileManager: ProfilePageUseCase {
    func loadFavoritesFromFirebase(completion: @escaping ([GifStickerCellConfigurable]?, String?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(nil, "User is not logged in")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                completion(nil, "Failed to load favorites: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists, let favoriteArray = document.data()?["favorites"] as? [String] {
                let homeViewModel = HomeViewModel()
                let favoriteItems = favoriteArray.compactMap { id in
                    homeViewModel.fetchItem(by: id)
                }
                completion(favoriteItems, nil)
            } else {
                completion(nil, "Document does not exist or favorites field is not valid")
            }
        }
    }

    func logout(completion: @escaping (String?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion("Error signing out: \(error.localizedDescription)")
        }
    }
}
