//
//  HomeViewModel.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation

//class HomeViewModel {
////    private let homeManager = HomeManager()
////    var gifs: [Datum] = []
////    var stickers: [StickerDatum] = []
////    var currentItems: [GifStickerCellConfigurable] = []
////    var isShowingGIFs = true
////    var onFetchCompleted: (() -> Void)?
////    var onFetchFailed: ((String) -> Void)?
//    private let homeManager = HomeManager()
//        var gifs: [Datum] = []
//        var stickers: [StickerDatum] = []
//        var emojis: [EmojiDatum] = []
//        var currentItems: [GifStickerCellConfigurable] = []
//        var isShowingGIFs = true
//        var onFetchCompleted: (() -> Void)?
//        var onFetchFailed: ((String) -> Void)?
//    
//    
//    func fetchTrendingGIFs() {
//        homeManager.getTrendingGIFs { [weak self] data, error in
//            if let data = data {
//                self?.gifs = data
//                self?.currentItems = data
//                self?.isShowingGIFs = true
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//    
//    func fetchTrendingStickers() {
//        homeManager.getTrendingStickers { [weak self] data, error in
//            if let data = data {
//                self?.stickers = data
//                self?.currentItems = data
//                self?.isShowingGIFs = false
//                self?.onFetchCompleted?()
//            } else if let error = error {
//                self?.onFetchFailed?(error)
//            }
//        }
//    }
//    
//    func fetchEmojis() {
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
////        func fetchEmojiVariations(for gifId: String) {
////            homeManager.getEmojiVariations(for: <#T##String#>, completion: <#T##([EmojiDatum]?, String?) -> Void#>)(for: gifId) { [weak self] emojiModel, error in
////                if let data = emojiModel?.data {
////                    // Handle emoji variations as needed
////                    self?.onFetchCompleted?()
////                } else if let error = error {
////                    self?.onFetchFailed?(error)
////                }
////            }
////        }
//}

class HomeViewModel {
    private let homeManager = HomeManager()
    var gifs: [Datum] = []
    var stickers: [StickerDatum] = []
    var emojis: [EmojiDatum] = []
    var currentItems: [GifStickerCellConfigurable] = []
    var onFetchCompleted: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    func fetchContent(for category: Int) {
            print("Fetching content for category: \(category)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                switch category {
                case 0: // GIFs
                    self?.fetchTrendingGIFs()
                case 1: // Stickers
                    self?.fetchTrendingStickers()
                case 2: // Emojis
                    self?.fetchEmojis()
                default:
                    print("Unknown category: \(category)")
                }
            }
        }

    private func fetchTrendingGIFs() {
        print("Fetching trending GIFs")
        homeManager.getTrendingGIFs { [weak self] data, error in
            if let data = data {
                print("Received \(data.count) GIFs")
                self?.gifs = data
                self?.currentItems = data
                self?.onFetchCompleted?()
            } else if let error = error {
                print("Error fetching GIFs: \(error)")
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
}
