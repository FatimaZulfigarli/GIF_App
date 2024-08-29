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
//
//class HomeViewModel {
//    private let homeManager = HomeManager()
//    var favorites: Set<String> = [] // Set to keep track of favorite item IDs
//
//    var selectedCategory: ContentType = .gif // Default category is GIF
//
//    var stickerSearchResults: [StickerDatum] = [] // Updated to StickerDatum
//    var gifSearchResults: [GIFDatum] = []  // Separate property for GIFSearch results
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
//    }
//
//    func removeFromFavorites(id: String) {
//        favorites.remove(id)
//    }
//
//    func saveFavoritesToFirebase() {
//            guard let userId = Auth.auth().currentUser?.uid else {
//                print("User is not logged in")
//                return
//            }
//
//            let db = Firestore.firestore()
//            let favoriteData = ["favorites": Array(favorites)]
//
//            db.collection("users").document(userId).setData(favoriteData) { error in
//                if let error = error {
//                    print("Failed to save favorites to Firebase: \(error)")
//                } else {
//                    print("Favorites successfully saved to Firebase.")
//                }
//            }
//        }
//
//        func loadFavoritesFromFirebase(completion: @escaping () -> Void) {
//            print("Attempting to load favorites from Firebase...") // Debugging line
//            guard let userId = Auth.auth().currentUser?.uid else {
//                print("User is not logged in")
//                completion()
//                return
//            }
//
//            let db = Firestore.firestore()
//            db.collection("users").document(userId).getDocument { [weak self] document, error in
//                if let document = document, document.exists {
//                    if let favoriteArray = document.data()?["favorites"] as? [String] {
//                        self?.favorites = Set(favoriteArray)
//                        print("Favorites loaded from Firebase: \(favoriteArray)") // Debugging line
//                        // Update currentItems with the fetched favorites
//                        self?.currentItems = favoriteArray.compactMap { favoriteId in
//                            // Implement a function to fetch item details using favoriteId
//                            self?.fetchItem(by: favoriteId)
//                        }
//                    }
//                } else {
//                    print("Failed to load favorites from Firebase: \(error?.localizedDescription ?? "No error description")")
//                }
//                completion()
//            }
//        }
//
//         func fetchItem(by id: String) -> GifStickerCellConfigurable? {
//            // Logic to fetch item details by its ID
//            // This is a placeholder; actual implementation would depend on your app's data structure
//            // Return nil or a mock item if the actual item cannot be fetched
//            return nil // Replace with actual fetching logic
//        }
//
//        func fetchContent(for category: ContentType) {
//            print("Fetching content for category: \(category)")
//            switch category {
//            case .gif:
//                fetchTrendingGIFs()
//            case .sticker:
//                fetchTrendingStickers()
//            case .emoji:
//                fetchEmojis()
//            }
//        }
//
//        private func fetchTrendingGIFs() {
//            homeManager.getTrendingGIFs { [weak self] data, error in
//                if let data = data {
//                    self?.gifs = data
//                    self?.currentItems = data
//                    self?.onFetchCompleted?()
//                } else if let error = error {
//                    self?.onFetchFailed?(error)
//                }
//            }
//        }
//
//        private func fetchTrendingStickers() {
//            homeManager.getTrendingStickers { [weak self] data, error in
//                if let data = data {
//                    self?.stickers = data
//                    self?.currentItems = data
//                    self?.onFetchCompleted?()
//                } else if let error = error {
//                    self?.onFetchFailed?(error)
//                }
//            }
//        }
//
//        private func fetchEmojis() {
//            homeManager.getEmojis { [weak self] data, error in
//                if let data = data {
//                    self?.emojis = data
//                    self?.currentItems = data
//                    self?.onFetchCompleted?()
//                } else if let error = error {
//                    self?.onFetchFailed?(error)
//                }
//            }
//        }
//
//        func searchContent(for category: ContentType, query: String) {
//            switch category {
//            case .gif:
//                searchGIFs(query: query)
//            case .sticker:
//                searchStickers(query: query)
//            default:
//                break
//            }
//        }
//
//        func searchGIFs(query: String) {
//            homeManager.searchGIFs(query: query) { [weak self] gifSearch, error in
//                if let gifSearch = gifSearch {
//                    self?.gifSearchResults = gifSearch.data ?? []
//                    self?.currentItems = gifSearch.data ?? []
//                    self?.onFetchCompleted?()
//                } else if let error = error {
//                    self?.onFetchFailed?(error)
//                }
//            }
//        }
//
//        func searchStickers(query: String) {
//            homeManager.searchStickers(query: query) { [weak self] stickerSearch, error in
//                if let error = error {
//                    print("Error searching Stickers: \(error)")
//                    self?.onFetchFailed?(error)
//                    return
//                }
//                print("Successfully searched Stickers")
//                self?.stickers = stickerSearch?.data ?? []
//                self?.currentItems = self?.stickers ?? []
//                self?.onFetchCompleted?()
//            }
//        }
enum ContentType: String {
    case gif = "Gif"
    case sticker = "Sticker"
    case emoji = "Emoji"
}

class HomeViewModel {
    private let homeManager = HomeManager()
    var favorites: Set<String> = [] // Set to keep track of favorite item IDs

    var selectedCategory: ContentType = .gif // Default category is GIF

    var stickerSearchResults: [StickerDatum] = [] // Updated to StickerDatum
    var gifSearchResults: [GIFDatum] = []  // Separate property for GIFSearch results

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

    func addToFavorites(id: String) {
        favorites.insert(id)
    }

    func removeFromFavorites(id: String) {
        favorites.remove(id)
    }

    func saveFavoritesToFirebase() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        // Get the current user's email
        let userEmail = Auth.auth().currentUser?.email
        
        // Prepare the data to be saved
        let favoriteData: [String: Any] = [
            "email": userEmail ?? "Unknown",  // Add the user's email to the data
            "favorites": Array(favorites)
        ]
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).setData(favoriteData) { error in
            if let error = error {
                print("Failed to save favorites to Firebase: \(error)")
            } else {
                print("Favorites and email successfully saved to Firebase.")
            }
        }
    }

    func loadFavoritesFromFirebase(completion: @escaping () -> Void) {
        print("Attempting to load favorites from Firebase...")
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            completion()
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            if let document = document, document.exists {
                if let favoriteArray = document.data()?["favorites"] as? [String] {
                    self?.favorites = Set(favoriteArray)
                    print("Favorites loaded from Firebase: \(favoriteArray)")
                    // Update currentItems with the fetched favorites
                    self?.currentItems = favoriteArray.compactMap { favoriteId in
                        self?.fetchItem(by: favoriteId)
                    }
                    print("Loaded favorite items: \(self?.currentItems ?? [])")
                }
            } else {
                print("Failed to load favorites from Firebase: \(error?.localizedDescription ?? "No error description")")
            }
            completion()
        }
    }

    func fetchItem(by id: String) -> GifStickerCellConfigurable? {
        // Fetch item by ID from gifs, stickers, or emojis
        if let gif = gifs.first(where: { $0.id == id }) {
            print("Fetched GIF for ID \(id): \(gif)")
            return gif
        } else if let sticker = stickers.first(where: { $0.id == id }) {
            print("Fetched Sticker for ID \(id): \(sticker)")
            return sticker
        } else if let emoji = emojis.first(where: { $0.id == id }) {
            print("Fetched Emoji for ID \(id): \(emoji)")
            return emoji
        } else {
            print("No item found for ID \(id)")
            return nil
        }
    }

    func fetchContent(for category: ContentType) {
        print("Fetching content for category: \(category)")
        switch category {
        case .gif:
            fetchTrendingGIFs()
        case .sticker:
            fetchTrendingStickers()
        case .emoji:
            fetchEmojis()
        }
    }

    private func fetchTrendingGIFs() {
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

    private func fetchTrendingStickers() {
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

    private func fetchEmojis() {
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
            if let error = error {
                print("Error searching Stickers: \(error)")
                self?.onFetchFailed?(error)
                return
            }
            print("Successfully searched Stickers")
            self?.stickers = stickerSearch?.data ?? []
            self?.currentItems = self?.stickers ?? []
            self?.onFetchCompleted?()
        }
    }
}
