//
//  HomeUseCase.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation



protocol HomeUseCase {
    func getTrendingGIFs(completion: @escaping ([Datum]?, String?) -> Void)
    func getTrendingStickers(completion: @escaping ([StickerDatum]?, String?) -> Void)
    func getEmojis(completion: @escaping ([EmojiDatum]?, String?) -> Void)
    func searchGIFs(query: String, completion: @escaping (GIFSearch?, String?) -> Void)
    func searchStickers(query: String, completion: @escaping (StickerSearch?, String?) -> Void)
}
