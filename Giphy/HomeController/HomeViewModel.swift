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


enum ContentType: String {
    case gif = "Gif"
    case sticker = "Sticker"
    case emoji = "Emoji"
}
//
//class HomeViewModel {
//    private let homeManager = HomeManager()
//    private var favorites: Set<String> = [] // Set to keep track of favorite item IDs
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
//    func isItemFavorite(id: String?) -> Bool {
//           guard let id = id else { return false }
//           return favorites.contains(id)
//       }
//
//       func addToFavorites(id: String) {
//           favorites.insert(id)
//       }
//
//       func removeFromFavorites(id: String) {
//           favorites.remove(id)
//       }
//
//       func saveFavoritesToFirebase() {
//           // Get a reference to Firebase
//           let db = Firestore.firestore()
//           let userId = "unique_user_id" // Replace with actual user ID
//           let favoriteData = ["favorites": Array(favorites)]
//           
//           db.collection("users").document(userId).setData(favoriteData) { error in
//               if let error = error {
//                   print("Failed to save favorites to Firebase: \(error)")
//               } else {
//                   print("Favorites successfully saved to Firebase.")
//               }
//           }
//       }
//
//       // Call this method during app launch to load favorites from Firebase
//       func loadFavoritesFromFirebase(completion: @escaping () -> Void) {
//           let db = Firestore.firestore()
//           let userId = "unique_user_id" // Replace with actual user ID
//           
//           db.collection("users").document(userId).getDocument { document, error in
//               if let document = document, document.exists {
//                   if let favoriteArray = document.data()?["favorites"] as? [String] {
//                       self.favorites = Set(favoriteArray)
//                   }
//               } else {
//                   print("Failed to load favorites from Firebase: \(error?.localizedDescription ?? "No error description")")
//               }
//               completion()
//           }
//       }
//   }
//    
//    func fetchContent(for category: ContentType) {
//        print("Fetching content for category: \(category)")
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
////    private func searchGIFs(query: String) {
////        homeManager.searchGIFs(query: query) { [weak self] gifSearch, error in
////            if let gifSearch = gifSearch {
////                self?.gifs = gifSearch.data ?? []
////                self?.currentItems = gifSearch.data ?? []
////                self?.onFetchCompleted?()
////            } else if let error = error {
////                self?.onFetchFailed?(error)
////            }
////        }
////    }
//     func searchGIFs(query: String) {
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
////    private func searchStickers(query: String) {
////        homeManager.searchStickers(query: query) { [weak self] stickerSearch, error in
////            if let stickerSearch = stickerSearch {
////                self?.stickers = stickerSearch.data ?? []
////                self?.currentItems = stickerSearch.data ?? []
////                self?.onFetchCompleted?()
////            } else if let error = error {
////                self?.onFetchFailed?(error)
////            }
////        }
////    }
////}
//
//     func searchStickers(query: String) {
//           homeManager.searchStickers(query: query) { [weak self] stickerSearch, error in
//               if let error = error {
//                   print("Error searching Stickers: \(error)")
//                   self?.onFetchFailed?(error)
//                   return
//               }
//               print("Successfully searched Stickers")
//               self?.stickers = stickerSearch?.data ?? []
//               self?.currentItems = self?.stickers ?? []
//               self?.onFetchCompleted?()
//           }
//       }
//   }

class HomeViewModel {
    private let homeManager = HomeManager()
    private var favorites: Set<String> = [] // Set to keep track of favorite item IDs

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

            // Get a reference to Firebase
            let db = Firestore.firestore()
            let favoriteData = ["favorites": Array(favorites)]

            db.collection("users").document(userId).setData(favoriteData) { error in
                if let error = error {
                    print("Failed to save favorites to Firebase: \(error)")
                } else {
                    print("Favorites successfully saved to Firebase.")
                }
            }
        }

    // Call this method during app launch to load favorites from Firebase
    func loadFavoritesFromFirebase(completion: @escaping () -> Void) {
           guard let userId = Auth.auth().currentUser?.uid else {
               print("User is not logged in")
               return
           }

           let db = Firestore.firestore()

           db.collection("users").document(userId).getDocument { document, error in
               if let document = document, document.exists {
                   if let favoriteArray = document.data()?["favorites"] as? [String] {
                       self.favorites = Set(favoriteArray)
                   }
               } else {
                   print("Failed to load favorites from Firebase: \(error?.localizedDescription ?? "No error description")")
               }
               completion()
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
