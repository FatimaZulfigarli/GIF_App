//
//  HomeManager.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation


class HomeManager {
    func fetchTrendingGIFs(completion: @escaping (GIFModel?, String?) -> Void) {
        NetworkManager.request(model: GIFModel.self, endpoint: .gifsTrending) { response, error in
            completion(response, error)
        }
    }
}
