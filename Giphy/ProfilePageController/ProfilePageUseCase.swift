//
//  ProfilePageUseCase.swift
//  Giphy
//
//  Created by Fatya on 29.08.24.
//

protocol ProfilePageUseCase {
    func fetchFavorites(completion: @escaping ([GifStickerCellConfigurable]) -> Void)
    func removeFavorite(id: String)
}
