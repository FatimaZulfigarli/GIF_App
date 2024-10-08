//
//  ProfilePageUseCase.swift
//  Giphy
//
//  Created by Fatya on 08.10.24.
//

import Foundation
protocol ProfilePageUseCase {
    func loadFavoritesFromFirebase(completion: @escaping ([GifStickerCellConfigurable]?, String?) -> Void)
    func logout(completion: @escaping (String?) -> Void)
}
