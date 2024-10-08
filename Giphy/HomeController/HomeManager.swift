import Foundation

class HomeManager: HomeUseCase {
    func getTrendingGIFs(completion: @escaping ([Datum]?, String?) -> Void) {
        NetworkManager.request(model: GIFModel.self, endpoint: .gifsTrending) { gifModel, error in
            completion(gifModel?.data, error)
        }
    }
    
    func getTrendingStickers(completion: @escaping ([StickerDatum]?, String?) -> Void) {
        NetworkManager.request(model: StickerModel.self, endpoint: .stickersTrending) { stickerModel, error in
            completion(stickerModel?.data, error)
        }
    }
    
    func getEmojis(completion: @escaping ([EmojiDatum]?, String?) -> Void) {
        NetworkManager.request(model: EmojiModel.self, endpoint: .emoji) { emojiModel, error in
            completion(emojiModel?.data, error)
        }
    }
    
    func searchGIFs(query: String, completion: @escaping (GIFSearch?, String?) -> Void) {
        NetworkManager.request(model: GIFSearch.self, endpoint: .gifsSearch(query: query), completion: completion)
    }
    
    
    func searchStickers(query: String, completion: @escaping (StickerSearch?, String?) -> Void) {
        print("Searching Stickers with query: \(query)")
        NetworkManager.request(model: StickerSearch.self, endpoint: .stickersSearch(query: query)) { stickerSearch, error in
            if let error = error {
                print("Error searching Stickers: \(error)")
            }
            completion(stickerSearch, error)
        }
    }
}

