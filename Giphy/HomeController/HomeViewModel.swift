//
//  HomeViewModel.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation

enum ContentType: String {
    case gif = "Gif"
    case sticker = "Sticker"
    case emoji = "Emoji"
}

//class HomeViewModel {
//    private let homeManager = HomeManager()
//    
//    var sticherSearchModel: StickerModel?
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
//    func fetchContent(for category: ContentType) {
//        print("Fetching content for category: \(category)")
//        switch category {
//        case .gif: // GIFs
//            fetchTrendingGIFs()
//        case .sticker: // Stickers
//            fetchTrendingStickers()
//        case .emoji: // Emojis
//            fetchEmojis()
//        }
//    }
//    
//    
//    
//    private func fetchTrendingGIFs() {
//        print("Fetching trending GIFs")
//        homeManager.getTrendingGIFs { [weak self] data, error in
//            if let data = data {
//                print("Received \(data.count) GIFs")
//                self?.gifs = data
//                self?.currentItems = data
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                print("Error fetching GIFs: \(error)")
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
//            break // No search for emojis
//        }
//    }
////    private func searchGIFs(query: String) {
////            homeManager.searchGIFs(query: query) { [weak self] gifSearch, error in
////                if let gifSearch = gifSearch {
////                    self?.gifSearchResults = gifSearch.gifData ?? []
////                    self?.currentItems = gifSearch.gifData ?? []
////                    self?.onFetchCompleted?()
////                } else if let error = error {
////                    self?.onFetchFailed?(error)
////                }
////            }
////        }
////    
////    private func searchGIFs(query: String) {
////        homeManager.searchGIFs(query: query) { [weak self] gifSearch, error in
////            if let gifSearch = gifSearch {
////                self?.gifSearchResults = gifSearch.gifData ?? []
////                self?.currentItems = gifSearch. ?? []
////                self?.onFetchCompleted?()
////            } else if let error = error {
////                self?.onFetchFailed?(error)
////            }
////        }
////    }
//    
//    private func searchGIFs(query: String) {
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
//    private func searchStickers(query: String) {
//        homeManager.searchStickers(query: query) { [weak self] response, error in
//            if let response {
//                self?.sticherSearchModel = response
//                self?.stickers = response.data ?? []
//                self?.currentItems = response.data ?? []
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//}
//
//
//

class HomeViewModel {
    private let homeManager = HomeManager()
    var selectedCategory: ContentType = .gif // Default category is GIF

    var stickerSearchResults: [StickerDatum] = [] // Updated to StickerDatum
    var gifSearchResults: [GIFDatum] = []  // Separate property for GIFSearch results

    var gifs: [Datum] = []
    var stickers: [StickerDatum] = []
    var emojis: [EmojiDatum] = []
    var currentItems: [GifStickerCellConfigurable] = []
    
    var onFetchCompleted: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
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
    
//    private func searchGIFs(query: String) {
//        homeManager.searchGIFs(query: query) { [weak self] gifSearch, error in
//            if let gifSearch = gifSearch {
//                self?.gifs = gifSearch.data ?? []
//                self?.currentItems = gifSearch.data ?? []
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
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
//    private func searchStickers(query: String) {
//        homeManager.searchStickers(query: query) { [weak self] stickerSearch, error in
//            if let stickerSearch = stickerSearch {
//                self?.stickers = stickerSearch.data ?? []
//                self?.currentItems = stickerSearch.data ?? []
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//}

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
