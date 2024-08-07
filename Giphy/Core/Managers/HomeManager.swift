//
//  HomeManager.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation

//
//class HomeManager: HomeUseCase {
//    func getTrendingGIFs(completion: @escaping ([Datum]?, String?) -> Void) {
//        NetworkManager.request(model: [Datum].self, endpoint: .gifsTrending, completion: completion)
//    }
//    
//    func getTrendingStickers(completion: @escaping ([StickerDatum]?, String?) -> Void) {
//        NetworkManager.request(model: [StickerDatum].self, endpoint: .stickersTrending, completion: completion)
//    }
//}


    
//    func getEmojiVariations(for gifId: String, completion: @escaping ([EmojiDatum]?, String?) -> Void) {
//        NetworkManager.request(model: EmojiModel.self, endpoint: .emojiVariations(gifId: gifId)) { emojiModel, error in
//            completion(emojiModel, error)
//        }
//    }
    
   
    
class HomeManager {
    func getTrendingGIFs(completion: @escaping ([Datum]?, String?) -> Void) {
        NetworkManager.request(model: GIFModel.self, endpoint: .gifsTrending) { model, error in
            completion(model?.data, error)
        }
    }
    
    func getTrendingStickers(completion: @escaping ([StickerDatum]?, String?) -> Void) {
        NetworkManager.request(model: StickerModel.self, endpoint: .stickersTrending) { model, error in
            completion(model?.data, error)
        }
    }
    
    func getEmojis(completion: @escaping ([EmojiDatum]?, String?) -> Void) {
        NetworkManager.request(model: EmojiModel.self, endpoint: .emoji) { model, error in
            completion(model?.data, error)
        }
    }
    
    func getEmojiVariations(for emojiId: String, completion: @escaping ([EmojiDatum]?, String?) -> Void) {
            NetworkManager.request(model: EmojiModel.self, endpoint: .emojiVariations(gifId: emojiId)) { model, error in
                completion(model?.data, error)
            }
        }
}
    
//    func fetchEmojis(completion: @escaping (EmojiModel?, String?) -> Void) {
//           
//        }
        
//        func fetchEmojiVariations(for gifId: String, completion: @escaping (EmojiModel?, String?) -> Void) {
//            
//        }

