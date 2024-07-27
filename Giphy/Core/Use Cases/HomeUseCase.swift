//
//  HomeUseCase.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation

class HomeUseCase {
    private let manager: HomeManager
    
    init(manager: HomeManager = HomeManager()) {
        self.manager = manager
    }
    
    func getTrendingGIFs(completion: @escaping ([Datum]?, String?) -> Void) {
        manager.fetchTrendingGIFs { gifModel, error in
            completion(gifModel?.data, error)
        }
    }
}
