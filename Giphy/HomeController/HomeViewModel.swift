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
    var onFetchCompleted: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    init(useCase: HomeUseCase = HomeUseCase()) {
        self.useCase = useCase
    }
    
    func fetchTrendingGIFs() {
        useCase.getTrendingGIFs { [weak self] data, error in
            if let data = data {
                self?.gifs = data
                self?.onFetchCompleted?()
            } else if let error = error {
                self?.onFetchFailed?(error)
            }
        }
    }
}
