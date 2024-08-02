//
//  HomeManager.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation


class HomeManager {
    func fetchTrendingGIFs(completion: @escaping (GIFModel?, String?) -> Void) {
        NetworkManager.request(model: GIFModel.self, endpoint: .gifsTrending, completion: completion) 
    }
    
    func fetchTrendingStickers(completion: @escaping (StickerModel?, String?) -> Void) {
        NetworkManager.request(model: StickerModel.self, endpoint: .stickersTrending, completion: completion)
    }
}
