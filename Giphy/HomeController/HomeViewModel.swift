//
//  HomeViewModel.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation

class HomeViewModel {
    private let useCase: HomeUseCase
    var gifs: [Datum] = []
    var stickers: [StickerDatum] = []
    var currentItems: [GifStickerCellConfigurable] = []
    var isShowingGIFs = true
    var onFetchCompleted: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    init(useCase: HomeUseCase = HomeUseCase()) {
        self.useCase = useCase
    }
    
    func fetchTrendingGIFs() {
        useCase.getTrendingGIFs { [weak self] data, error in
            if let data = data {
                self?.gifs = data
                self?.currentItems = data
                self?.isShowingGIFs = true
                self?.onFetchCompleted?()
            } else if let error = error {
                self?.onFetchFailed?(error)
            }
        }
    }
    
    func fetchTrendingStickers() {
        useCase.getTrendingStickers { [weak self] data, error in
            if let data = data {
                self?.stickers = data
                self?.currentItems = data
                self?.isShowingGIFs = false
                self?.onFetchCompleted?()
            } else if let error = error {
                self?.onFetchFailed?(error)
            }
        }
    }
}
