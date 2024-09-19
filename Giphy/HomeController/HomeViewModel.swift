//
//  HomeViewModel.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth 

//
//enum ContentType: String {
//    case gif = "Gif"
//    case sticker = "Sticker"
//    case emoji = "Emoji"
//}
//
//class HomeViewModel {
//    private let homeManager = HomeManager()
//    var favorites: Set<String> = [] // Set to keep track of favorite item IDs
//
//    var selectedCategory: ContentType = .gif // Default category is GIF
//
//    var stickerSearchResults: [StickerDatum] = []
//    var gifSearchResults: [GIFDatum] = []
//
//    var gifs: [Datum] = []
//    var stickers: [StickerDatum] = []
//    var emojis: [EmojiDatum] = []
//    var currentItems: [GifStickerCellConfigurable] = []
//
//    var onFetchCompleted: (() -> Void)?
//    var onFetchFailed: ((String) -> Void)?
//
//    func isItemFavorite(id: String?) -> Bool {
//        guard let id = id else { return false }
//        return favorites.contains(id)
//    }
//
//    func addToFavorites(id: String) {
//        favorites.insert(id)
//        saveFavoritesToFirebase()
//    }
//
//    func removeFromFavorites(id: String) {
//        favorites.remove(id)
//        saveFavoritesToFirebase()
//    }
//
//    func saveFavoritesToFirebase() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User is not logged in")
//            return
//        }
//
//        let db = Firestore.firestore()
//        let favoriteData = ["favorites": Array(favorites)]
//
//        db.collection("users").document(userId).setData(favoriteData) { error in
//            if let error = error {
//                print("Failed to save favorites to Firebase: \(error)")
//            } else {
//                print("Favorites successfully saved to Firebase.")
//            }
//        }
//    }
//
////    func loadFavoritesFromFirebase(completion: @escaping () -> Void) {
////        guard let userId = Auth.auth().currentUser?.uid else {
////            print("User is not logged in")
////            completion()
////            return
////        }
////
////        let db = Firestore.firestore()
////        db.collection("users").document(userId).getDocument { [weak self] document, error in
////            if let document = document, document.exists {
////                if let favoriteArray = document.data()?["favorites"] as? [String] {
////                    self?.favorites = Set(favoriteArray)
////                }
////            } else {
////                print("Failed to load favorites from Firebase: \(error?.localizedDescription ?? "No error description")")
////            }
////            completion()
////        }
////    }
//
//    func loadFavoritesFromFirebase(completion: @escaping () -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User is not logged in")
//            completion()
//            return
//        }
//
//        let db = Firestore.firestore()
//        db.collection("users").document(userId).getDocument { [weak self] document, error in
//            if let error = error {
//                print("Failed to load favorites from Firebase: \(error.localizedDescription)")
//                completion()
//                return
//            }
//
//            if let document = document, document.exists {
//                if let favoriteArray = document.data()?["favorites"] as? [String] {
//                    self?.favorites = Set(favoriteArray)
//                    print("Favorites loaded from Firebase: \(favoriteArray)")
//                } else {
//                    print("Favorites field does not exist or is not a valid format")
//                }
//            } else {
//                print("Document does not exist")
//            }
//            completion()
//        }
//    }
//
//    func fetchItem(by id: String) -> GifStickerCellConfigurable? {
//        // Fetch item by ID from gifs, stickers, or emojis
//        if let gif = gifs.first(where: { $0.id == id }) {
//            return gif
//        } else if let sticker = stickers.first(where: { $0.id == id }) {
//            return sticker
//        } else if let emoji = emojis.first(where: { $0.id == id }) {
//            return emoji
//        } else {
//            return nil
//        }
//    }
//
//    func fetchContent(for category: ContentType) {
//        switch category {
//        case .gif:
//            fetchTrendingGIFs()
//        case .sticker:
//            fetchTrendingStickers()
//        case .emoji:
//            fetchEmojis()
//        }
//    }
//
//    private func fetchTrendingGIFs() {
//        homeManager.getTrendingGIFs { [weak self] data, error in
//            if let data = data {
//                self?.gifs = data
//                self?.currentItems = data
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//
//    private func fetchTrendingStickers() {
//        homeManager.getTrendingStickers { [weak self] data, error in
//            if let data = data {
//                self?.stickers = data
//                self?.currentItems = data
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//
//    private func fetchEmojis() {
//        homeManager.getEmojis { [weak self] data, error in
//            if let data = data {
//                self?.emojis = data
//                self?.currentItems = data
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//
//    func searchContent(for category: ContentType, query: String) {
//        switch category {
//        case .gif:
//            searchGIFs(query: query)
//        case .sticker:
//            searchStickers(query: query)
//        default:
//            break
//        }
//    }
//
//    func searchGIFs(query: String) {
//        homeManager.searchGIFs(query: query) { [weak self] gifSearch, error in
//            if let gifSearch = gifSearch {
//                self?.gifSearchResults = gifSearch.data ?? []
//                self?.currentItems = gifSearch.data ?? []
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//
//    func searchStickers(query: String) {
//        homeManager.searchStickers(query: query) { [weak self] stickerSearch, error in
//            if let stickerSearch = stickerSearch {
//                self?.stickers = stickerSearch.data ?? []
//                self?.currentItems = self?.stickers ?? []
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//}
//

//
//  HomeViewModel.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

enum ContentType: String {
    case gif = "Gif"
    case sticker = "Sticker"
    case emoji = "Emoji"
}

class HomeViewModel {
    private let homeManager = HomeManager()
    var favorites: Set<String> = [] // Set to keep track of favorite item IDs

    var selectedCategory: ContentType = .gif // Default category is GIF

    var stickerSearchResults: [StickerDatum] = []
    var gifSearchResults: [GIFDatum] = []

    var gifs: [Datum] = []
    var stickers: [StickerDatum] = []
    var emojis: [EmojiDatum] = []
    var currentItems: [GifStickerCellConfigurable] = []

    var onFetchCompleted: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?

    func isItemFavorite(id: String?) -> Bool {
        guard let id = id else { return false }
        return favorites.contains(id)
    }

//    func addToFavorites(id: String) {
//        favorites.insert(id)
//        saveFavoritesToFirebase()
//    }
//
//    func removeFromFavorites(id: String) {
//        favorites.remove(id)
//        saveFavoritesToFirebase()
//    }
//
//    func saveFavoritesToFirebase() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User is not logged in")
//            return
//        }
//
//        let db = Firestore.firestore()
//        let favoriteData = ["favorites": Array(favorites)]
//
//        db.collection("users").document(userId).setData(favoriteData) { error in
//            if let error = error {
//                print("Failed to save favorites to Firebase: \(error)")
//            } else {
//                print("Favorites successfully saved to Firebase.")
//            }
//        }
//    }
//
//    
    func addToFavorites(id: String) {
        // Only add if the item is not already a favorite
        if !favorites.contains(id) {
            favorites.insert(id) // Add to the in-memory set
            saveFavoritesToFirebase() // Save the updated set to Firebase
        }
    }

    func removeFromFavorites(id: String) {
        favorites.remove(id) // Remove from the in-memory set
        saveFavoritesToFirebase() // Save the updated set to Firebase
    }

    func saveFavoritesToFirebase() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }

        let db = Firestore.firestore()
        let favoriteData = ["favorites": Array(favorites)] // Convert Set to Array

        db.collection("users").document(userId).setData(favoriteData, merge: true) { error in
            if let error = error {
                print("Failed to save favorites to Firebase: \(error)")
            } else {
                print("Favorites successfully saved to Firebase.")
            }
        }
    }
    
//    func loadFavoritesFromFirebase(completion: @escaping () -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User is not logged in")
//            completion()
//            return
//        }
//
//        let db = Firestore.firestore()
//        db.collection("users").document(userId).getDocument { [weak self] document, error in
//            if let error = error {
//                print("Failed to load favorites from Firebase: \(error.localizedDescription)")
//                completion()
//                return
//            }
//
//            if let document = document, document.exists {
//                if let favoriteArray = document.data()?["favorites"] as? [String] {
//                    self?.favorites = Set(favoriteArray)
//                    print("Favorites loaded from Firebase: \(favoriteArray)")
//                } else {
//                    print("Favorites field does not exist or is not a valid format")
//                }
//            } else {
//                print("Document does not exist")
//            }
//            completion()
//        }
//    }
    
    func loadFavoritesFromFirebase(completion: @escaping () -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            completion()
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            if let error = error {
                print("Failed to load favorites from Firebase: \(error.localizedDescription)")
                completion()
                return
            }

            if let document = document, document.exists {
                if let favoriteArray = document.data()?["favorites"] as? [String] {
                    self?.favorites = Set(favoriteArray) // Keep all current favorites
                    print("Favorites loaded from Firebase: \(favoriteArray)")
                } else {
                    print("No favorites field or invalid format")
                }
            } else {
                print("Document does not exist")
            }
            completion()
        }
    }

    func fetchItem(by id: String) -> GifStickerCellConfigurable? {
        // Fetch item by ID from gifs, stickers, or emojis
        if let gif = gifs.first(where: { $0.id == id }) {
            return gif
        } else if let sticker = stickers.first(where: { $0.id == id }) {
            return sticker
        } else if let emoji = emojis.first(where: { $0.id == id }) {
            return emoji
        } else {
            return nil
        }
    }

    func fetchContent(for category: ContentType) {
        switch category {
        case .gif:
            fetchTrendingGIFs()
        case .sticker:
            fetchTrendingStickers()
        case .emoji:
            fetchEmojis()
        }
    }

    func fetchTrendingGIFs() {
        homeManager.getTrendingGIFs { [weak self] data, error in
            if let data = data {
                self?.gifs = data
                self?.currentItems = data
                self?.onFetchCompleted?()
            } else if let error = error {
                self?.onFetchFailed?(error)
            }
        }
    }

     func fetchTrendingStickers() {
        homeManager.getTrendingStickers { [weak self] data, error in
            if let data = data {
                self?.stickers = data
                self?.currentItems = data
                self?.onFetchCompleted?()
            } else if let error = error {
                self?.onFetchFailed?(error)
            }
        }
    }

     func fetchEmojis() {
        homeManager.getEmojis { [weak self] data, error in
            if let data = data {
                self?.emojis = data
                self?.currentItems = data
                self?.onFetchCompleted?()
            } else if let error = error {
                self?.onFetchFailed?(error)
            }
        }
    }

    func searchContent(for category: ContentType, query: String) {
        switch category {
        case .gif:
            searchGIFs(query: query)
        case .sticker:
            searchStickers(query: query)
        default:
            break
        }
    }

    func searchGIFs(query: String) {
        homeManager.searchGIFs(query: query) { [weak self] gifSearch, error in
            if let gifSearch = gifSearch {
                self?.gifSearchResults = gifSearch.data ?? []
                self?.currentItems = gifSearch.data ?? []
                self?.onFetchCompleted?()
            } else if let error = error {
                self?.onFetchFailed?(error)
            }
        }
    }

    func searchStickers(query: String) {
        homeManager.searchStickers(query: query) { [weak self] stickerSearch, error in
            if let stickerSearch = stickerSearch {
                self?.stickerSearchResults = stickerSearch.data ?? []
                self?.currentItems = self?.stickerSearchResults ?? []
                self?.onFetchCompleted?()
            } else if let error = error {
                self?.onFetchFailed?(error)
            }
        }
    }
}
