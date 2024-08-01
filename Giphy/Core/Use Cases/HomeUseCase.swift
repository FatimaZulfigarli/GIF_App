//
//  HomeUseCase.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation

class HomeUseCase {
    private let manager = HomeManager()

    func getTrendingGIFs(completion: @escaping ([Datum]?, String?) -> Void) {
        manager.fetchTrendingGIFs { gifModel, error in
            completion(gifModel?.data, error)
        }
    }
    
    func getTrendingStickers(completion: @escaping ([StickerDatum]?, String?) -> Void) {
        manager.fetchTrendingStickers { stickerModel, error in
            completion(stickerModel?.data, error)
        }
    }
}
