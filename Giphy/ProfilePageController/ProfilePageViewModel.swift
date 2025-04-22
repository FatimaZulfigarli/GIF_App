//
//  ProfilePageViewModel.swift
//  Giphy
//
//  Created by Fatya on 08.10.24.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore
class ProfilePageViewModel {
    private let profileManager: ProfilePageUseCase
    var onFavoritesLoaded: (([GifStickerCellConfigurable]) -> Void)?
    var onError: ((String) -> Void)?
    var onLogoutSuccess: (() -> Void)?
    
    var favoriteItems: [GifStickerCellConfigurable] = []
    
    init(profileManager: ProfilePageUseCase = ProfileManager()) {
        self.profileManager = profileManager
    }
    
    func loadFavorites() {
        profileManager.loadFavoritesFromFirebase { [weak self] favorites, error in
            if let error = error {
                self?.onError?(error)
            } else if let favorites = favorites {
                self?.favoriteItems = favorites
                self?.onFavoritesLoaded?(favorites)
            }
        }
    }
    
    func logout() {
        profileManager.logout { [weak self] error in
            if let error = error {
                self?.onError?(error)
            } else {
                self?.onLogoutSuccess?()
            }
        }
    }
}
