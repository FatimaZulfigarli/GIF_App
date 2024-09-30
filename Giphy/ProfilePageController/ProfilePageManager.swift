//
//  ProfilePageManager.swift
//  Giphy
//
//  Created by Fatya on 29.08.24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestore

class ProfilePageManager {
    func fetchFavorites(completion: @escaping ([GifStickerCellConfigurable]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            completion([])
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { document, error in
            if let document = document, document.exists {
                if let favoriteArray = document.data()?["favorites"] as? [String] {
                    let favorites = favoriteArray.compactMap { id in
                        // Fetch the actual items using the ID
                        // For now, just returning mock data
                        return GifStickerCellConfigurable(id: id, name: "Item \(id)")
                    }
                    completion(favorites)
                } else {
                    completion([])
                }
            } else {
                completion([])
            }
        }
    }

    func removeFavorite(id: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData([
            "favorites": FieldValue.arrayRemove([id])
        ]) { error in
            if let error = error {
                print("Error removing favorite: \(error.localizedDescription)")
            } else {
                print("Favorite successfully removed")
            }
        }
    }
}
